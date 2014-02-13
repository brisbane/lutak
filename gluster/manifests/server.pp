# Class: gluster::server
#
# This module manages gluster server
#
class gluster::server (
  $package_ensure = $gluster::params::package_ensure,
) inherits gluster::params {
  package { 'glusterfs-fuse':
    ensure  => $package_ensure,
  }
  package { 'glusterfs-server':
    ensure  => $package_ensure,
  }
  service { 'glusterd':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['glusterfs-server'],
  }
}
