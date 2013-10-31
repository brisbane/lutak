# Define: users::useraccount
#
# This define adds user account to local system
#
# Parameters:
#
# Actions:
#   - Install Apache
#   - Manage Apache service
#
# Requires:
#   - get_module_path() form stdlib
#
# Sample Usage:
#
define users::useraccount (
  $ensure   = present,
  $comment  = '',
  $uid      = '',
  $groups   = [],
  $shell    = '/bin/bash',
  $password = '',
  $sshkeys  = [],
  $recurse  = false,
) {
  $username = $name
  # This case statement will allow disabling an account by passing
  # ensure => absent, to set the home directory ownership to root.
  case $ensure {
    present: {
      $home_owner = $username
      $home_group = $username
    }
    default: {
      $home_owner = 'root'
      $home_group = 'root'
    }
  }

  # Default user settings
  user { $username:
    ensure     => $ensure,
    gid        => $username,
    groups     => $groups,
    comment    => "${comment} ",
    home       => "/home/${username}",
    shell      => $shell,
    allowdupe  => false,
    managehome => true,
    require    => Group[$username],
  }

  # Default group settings
  group { $username:
    ensure    => $ensure,
    allowdupe => false,
  }

  # set password, or force user on first login
  if $password != '' {
    User <| title == $username |> { password => $password }
  }
  else {
    exec { "setpassonlogin_${username}":
      command     => "usermod -p '' ${username} && chage -d 0 ${username}",
      unless      => "grep ${username} /etc/shadow | cut -f 2 -d : | grep -v '!'  > /dev/null",
      refreshonly => true,
      subscribe   => User[$username],
      require     => User[$username],
    }
  }

  # uid/gid management
  if $uid != '' {
    # Manage uid if etcpass is available
    if $::etcpasswd != '' {
      User <| title == $username |> { uid => $uid }
      users::uidsanity { $uid:   username => $username }
    }

    # Manage gid if etcgroup is available
    if $::etcgroup != '' {
      User <| title == $username |> { gid => $uid }
      Group <| title == $username |> { gid => $uid }
      users::gidsanity { $uid: groupname => $username }
    }
  }

  $managedDirs = [
    "/etc/puppet/files/users/home/host/${username}.${::fqdn}",
    "/etc/puppet/files/users/home/host/${username}.${::hostname}",
    "/etc/puppet/files/users/home/domain/${username}.${::domain}",
    "/etc/puppet/files/users/home/env/${username}.${::environment}",
    "/etc/puppet/files/users/home/user/${username}",
    '/etc/puppet/files/users/home/skel',
  ]

  # get path of current module
  $mypath = get_module_path('users')
  case generate("${mypath}/scripts/findDirs.sh", $managedDirs) {
      '': {
          file { "/home/${username}":
              ensure  => directory,
              owner   => $home_owner,
              group   => $home_group,
              recurse => $recurse,
              replace => false,
              ignore  => '.git',
              source  => [
                  "puppet:///files/users/home/default/host/${username}.${::fqdn}",
                  "puppet:///files/users/home/default/host/${username}.${::hostname}",
                  "puppet:///files/users/home/default/domain/${username}.${::domain}",
                  "puppet:///files/users/home/default/env/${username}.${::environment}",
                  "puppet:///files/users/home/default/user/${username}",
                  'puppet:///files/users/home/default/skel',
                  'puppet:///files/users/home/default',
              ],
              require => User[$username],
          }
      }
      default: {
          file { "/home/${username}":
              ensure  => directory,
              owner   => $home_owner,
              group   => $home_group,
              recurse => $recurse,
              replace => true,
              force   => true,
              ignore  => '.git',
              source  => [
                  "puppet:///files/users/home/host/${username}.${::fqdn}",
                  "puppet:///files/users/home/host/${username}.${::hostname}",
                  "puppet:///files/users/home/domain/${username}.${::domain}",
                  "puppet:///files/users/home/env/${username}.${::environment}",
                  "puppet:///files/users/home/user/${username}",
                  'puppet:///files/users/home/skel',
              ],
              require => User[$username],
          }
      }
  }

  file { "/home/${username}/.bash_history":
    ensure  => file,
    mode    => '0600',
    owner   => $home_owner,
    group   => $home_group,
    require => File["/home/${username}"],
  }

  file { "/home/${username}/.ssh":
    ensure  => directory,
    owner   => $home_owner,
    group   => $home_group,
    mode    => '0700',
    require => File["/home/${username}"],
  }

  # add SSH keys if told to
  if $sshkeys != [] {
    users::sshkey{ $sshkeys:
      ensure => present,
      user   => $username,
    }
  }
}

# vi:syntax=puppet:filetype=puppet:ts=4:et:
