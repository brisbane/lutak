# Class: gluster::client
#
# This module manages gluster client
#
class gluster::params {
  $package_ensure = 'present'
  $glusterdir     = '/gluster'
}
