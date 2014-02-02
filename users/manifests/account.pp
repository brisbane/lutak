#
# = Define: users::account
#
# This define adds user account to local system
#
define users::account (
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
    uid        => $uid,
    gid        => $uid,
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
    gid       => $uid,
    allowdupe => false,
  }

  # set password, or force user on first login
  if $password != '' {
    User [$username] { password => $password }
  } else {
    exec { "setpassonlogin_${username}":
      command     => "/usr/sbin/usermod -p '' ${username} && chage -d 0 ${username}",
      unless      => "/bin/grep ${username} /etc/shadow | /usr/bin/cut -f 2 -d : | /bin/grep -v '!' > /dev/null",
      refreshonly => true,
      subscribe   => User[$username],
      require     => User[$username],
    }
  }

  file { "/home/${username}":
    ensure  => directory,
    owner   => $home_owner,
    group   => $home_group,
    recurse => $recurse,
    replace => true,
    force   => true,
    require => User[$username],
  }

  file { "/home/${username}/.bash_history":
    ensure  => file,
    mode    => '0600',
    owner   => $home_owner,
    group   => $home_group,
    require => File["/home/${username}"],
  }

  file { "/home/${username}/.ssh":
    ensure => directory,
    owner  => $home_owner,
    group  => $home_group,
    mode   => '0700',
  }

  # add sshkeys to user account if keys are defined at hiera
  if $sshkeys {
    ::users::sshkey { $sshkeys :
      user => $username,
    }
  }

}
# vi:syntax=puppet:filetype=puppet:ts=4:et:
