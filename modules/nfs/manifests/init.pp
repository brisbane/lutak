# Class: nfs
#
# This module manages NFS
#
class nfs {
    package { 'nfs-utils':
      ensure  => 'present',
    }
    service { 'nfslock':
      ensure   => running,
      enable   => true,
      provider => 'redhat',
      require  => Package['nfs-utils'],
    }
    package { 'portmap':
      ensure  => 'present',
    }
    service { 'portmap':
      ensure   => running,
      enable   => true,
      provider => 'redhat',
      require  => Package['portmap'],
    }
}
