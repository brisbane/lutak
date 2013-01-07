# Class: yum::repo::vmware
#
# This module manages vmware repo files for $operatingsystemrelease
#
class yum::repo::vmware {
  require yum
  class { 'yum::repodef::vmware': stage => 'yumsetup' }
}
