# Class: infiniband::srp
#
# This module manages OpenIB SCSI RDMA Protocol
#
class infiniband::srp {
  include infiniband
  package { 'srptools':
    ensure => present,
  }
#   service { 'srpd':
#     ensure   => running,
#     enable   => true,
#     provider => redhat,
#     require  => [ Package['srptools'], Service['rdma'] ],
#   }
}
