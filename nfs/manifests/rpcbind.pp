# Class: nfs::rpcbind
#
# This module manages rpcbind
#
class nfs::rpcbind {
  # rpcbind was in portmap package in RHEL5
  case $::operatingsystemrelease {
    default : {
      $rpcbind_name = 'rpcbind'
    }
    /^5.*/: {
      $rpcbind_name = 'portmap'
    }
  }

  package { 'rpcbind':
    ensure  => 'present',
    name    => $rpcbind_name,
  }
  service { 'rpcbind':
    ensure   => running,
    name     => $rpcbind_name,
    enable   => true,
    provider => 'redhat',
    require  => Package['rpcbind'],
  }
}
