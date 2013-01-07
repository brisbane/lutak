# Class: nfs::nfslock
#
# This module manages nfslock
#
class nfs::nfslock inherits nfs::rpcbind {
  package { 'nfs-utils':
    ensure  => 'present',
  }
  service { 'nfslock':
    ensure   => running,
    enable   => true,
    provider => 'redhat',
    # Service['rpcbind'] is defined in nfs::rpcbind
    require  => [ Package['nfs-utils'], Service['rpcbind'], ],
  }
}
