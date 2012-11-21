# Class: gluster::server
#
# This module manages gluster server
#
class gluster::server (
  $version    = $gluster::params::version,
) inherits gluster::params {
  package { 'glusterfs-server':
      ensure  => "$version",
  }
  service { 'glusterd':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['glusterfs-server'],
  }

}
