# Class: yum::repo::atomic
#
# This module manages ATOMIC repo files for $operatingsystemrelease
#
class yum::repo::atomic {
  require yum
  class { 'yum::repodef::atomic': stage => 'yumsetup' }
}
