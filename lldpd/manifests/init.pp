# Class: lldpd
#
# This module deploys lldpd
#
class lldpd {
  if "x${::is_virtual}" == 'xfalse' {
    package { 'lldpd':
      ensure => present,
    }
    service { 'lldpd':
      ensure   => running,
      enable   => true,
      provider => redhat,
      require  => Package['lldpd'],
    }
  }
}
