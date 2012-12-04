# Class: nfs
#
# This module manages NFS
#
class nfs {
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

    # nfs utils
    package { 'nfs-utils':
      ensure  => 'present',
    }
    service { 'nfslock':
      ensure   => running,
      enable   => true,
      provider => 'redhat',
      require  => [ Package['nfs-utils'], Service['rpcbind'], ],
    }


}
