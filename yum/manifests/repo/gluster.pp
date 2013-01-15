# Class: yum::repo::puppetlabls
#
# This module manages PuppetLabs repo files for $lsbdistrelease
#
class yum::repo::gluster {
  require yum
  class { 'yum::repodef::gluster': stage => 'yumsetup' }
}
