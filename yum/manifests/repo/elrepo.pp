# Class: yum::repo::elrepo
#
# This module manages elrepo repo files for $operatingsystemrelease
#
class yum::repo::elrepo {
  require yum
  class { 'yum::repodef::elrepo': stage => 'yumsetup' }
}
