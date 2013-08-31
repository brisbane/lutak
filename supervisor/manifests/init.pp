# Class: supervisor
#
# This modules installs and manages supervisor
#
class supervisor {
  package { 'supervisor':
    ensure => installed,
  }

  service { 'supervisord':
    ensure  => running,
    enable  => true,
    require => Package['supervisor'],
  }
}
