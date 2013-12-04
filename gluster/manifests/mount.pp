# Class: gluster::client
#
# This module manages gluster client
#
define gluster::mount ($volume, $mnt, $rdma_mount = false) {
  include ::gluster::client

  # make sure volume is mounted via rdma
  if $rdma_mount == 'true' {
    require ::gluster::rdma
    $volumeName = "${volume}.rdma"
  } else {
    $volumeName = $volume
  }

  file { $mnt:
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
  }
  mount { $mnt:
    ensure  => mounted,
    atboot  => true,
    device  => $volumeName,
    fstype  => 'glusterfs',
    options => 'defaults,_netdev',
    dump    => 0,
    pass    => 0,
    require => [ Package['glusterfs-fuse'], File[$mnt] ],
  }
}
