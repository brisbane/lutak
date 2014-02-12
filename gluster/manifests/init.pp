# Class: gluster
#
# This module manages gluster
#
class gluster (
  $package_ensure = $gluster::params::package_ensure,
  $glusterdir     = $gluster::params::glusterdir,
) inherits gluster::params {
  package { 'glusterfs':
    ensure => $package_ensure,
  }
}
