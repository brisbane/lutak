# Class: apache
#
# This class installs Apache
#
# Parameters:
#
# Actions:
#   - Install Apache
#   - Manage Apache service
#
# Requires:
#
# Sample Usage:
#
class apache (
  $default_mods         = true,
  $service_enable       = true,
  $serveradmin          = 'root@localhost',
  $sendfile             = false,
  $startservers         = $apache::params::startservers,
  $minspareservers      = $apache::params::minspareservers,
  $maxspareservers      = $apache::params::maxspareservers,
  $serverlimit          = $apache::params::serverlimit,
  $maxclients           = $apache::params::maxclients,
  $maxrequestsperchild  = $apache::params::maxrequestsperchild,
  $minsparethreads      = $apache::params::minsparethreads,
  $maxsparethreads      = $apache::params::maxsparethreads,
  $threadsperchild      = $apache::params::threadsperchild,
  $maxkeepaliverequests = $apache::params::maxkeepaliverequests,
  $keepalivetimeout     = $apache::params::keepalivetimeout,
  $servertimeout        = $apache::params::servertimeout,
  $user                 = $apache::params::user,
  $group                = $apache::params::group,
  $umask                = $apache::params::umask,
) inherits apache::params {

  package { 'httpd':
    ensure => installed,
    name   => $apache::params::apache_name,
  }

  if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
    file { '/etc/sysconfig/httpd':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('apache/sysconfig.httpd.erb'),
      notify  => Service['httpd'],
      require => Package['httpd'],
    }
  }

  # true/false is sufficient for both ensure and enable
  validate_bool($service_enable)

  service { 'httpd':
    ensure    => $service_enable,
    name      => $apache::params::apache_name,
    enable    => $service_enable,
    subscribe => Package['httpd'],
  }

  file { 'httpd_vdir':
    ensure  => directory,
    path    => $apache::params::vdir,
    recurse => true,
    purge   => true,
    notify  => Service['httpd'],
    require => Package['httpd'],
  }

  if $apache::params::conf_dir and $apache::params::conf_file {
    # Template uses:
    # - $apache::params::user
    # - $apache::params::group
    # - $apache::params::conf_dir
    # - $serveradmin
    file { "${apache::params::conf_dir}/${apache::params::conf_file}":
      ensure  => present,
      content => template("apache/${apache::params::conf_file}.erb"),
      notify  => Service['httpd'],
      require => Package['httpd'],
    }
    include apache::mod::minimal
  }
  if $apache::params::mod_dir {
    file { $apache::params::mod_dir:
      ensure  => directory,
      require => Package['httpd'],
    } -> A2mod <| |>
    resources { 'a2mod':
      purge => true,
    }
  }
}
