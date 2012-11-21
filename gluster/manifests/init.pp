# Class: gluster
#
# This module manages gluster
#
class gluster (
  $glusterdir = $gluster::params::glusterdir,
  $version    = $gluster::params::version,
) inherits gluster::params {
  package { 'glusterfs':
      ensure  => "$version",
  }
}
