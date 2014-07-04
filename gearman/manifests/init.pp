# Class: gearman
#
# This modules installs and manages gearman
#
class gearman {
  package { 'gearmand':
    ensure => installed,
  }

  service { 'gearmand':
    ensure  => running,
    enable  => true,
    require => Package['gearmand'],
  }
}
