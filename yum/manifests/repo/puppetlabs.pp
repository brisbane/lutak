# Class: yum::repo::puppetlabls
#
# This module manages PuppetLabs repo files for $lsbdistrelease
#
class yum::repo::puppetlabs {
  require yum
  class { 'yum::repodef::puppetlabs': stage => 'yumsetup' }
}
