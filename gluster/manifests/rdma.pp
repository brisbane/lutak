# Class: gluster::server
#
# This module manages gluster server
#
class gluster::rdma (
  $package_ensure = $gluster::params::package_ensure,
) inherits gluster::params {
  package { 'glusterfs-rdma':
      ensure  => $package_ensure,
  }
}
