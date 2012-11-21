# Class: gluster::server
#
# This module manages gluster server
#
class gluster::rdma (
  $version    = $gluster::params::version,
) inherits gluster::params {
  package { 'glusterfs-rdma':
      ensure  => "$version",
  }
}
