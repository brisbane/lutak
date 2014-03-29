# Class: gluster::client
#
# This module manages gluster client
#
class gluster::client (
  $package_ensure = $gluster::params::package_ensure,
  $glusterdir     = $gluster::params::glusterdir,
) inherits gluster::params {
  package { 'glusterfs-fuse':
    ensure => $package_ensure,
  }
}
