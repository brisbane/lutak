# Class: yum::repo::rpmforge
#
# This module manages Base repo files for $operatingsystemrelease
#
class yum::repo::rpmforge {
  require yum
  class { 'yum::repodef::rpmforge': stage => 'yumsetup' }
}
