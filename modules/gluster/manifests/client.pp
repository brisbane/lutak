# Class: gluster::client
#
# This module manages gluster client
#
class gluster::client (
  $glusterdir = $gluster::params::glusterdir,
  $version    = $gluster::params::version,
) inherits gluster::params {
  package { 'glusterfs-fuse':
      ensure  => "$version",
  }
  file { "$glusterdir":
        ensure  => directory,
        owner   => root,
        group   => root,
        mode    => 0755,
  }
  mount { "$glusterdir":
        ensure  => mounted,
        atboot  => true,
        device  => 'gluster01-vlan20:/sh',
        fstype  => 'glusterfs',
        options => 'defaults,_netdev',
        dump    => 0,
        pass    => 0,
        require => [ Package['glusterfs-fuse'], File["$glusterdir"], ],
  }
}
