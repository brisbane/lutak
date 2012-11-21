# Class: infiniband::sm
#
# This module manages OpenIB Subnet Manager
#
class infiniband::sm {
  include infiniband
  package { 'opensm':
    ensure => present,
  }
  service { 'opensm':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => [ Package['opensm'], Service['rdma'] ],
  }
}
