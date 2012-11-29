# Class: lldpd
#
# This module deploys lldpd
#
class lldpd {
  if $::is_virtual == false {
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
