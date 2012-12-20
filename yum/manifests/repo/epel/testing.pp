# Class: yum::repo::epel::testing
#
# This module manages EPEL testing repo files for $lsbdistrelease
#
class yum::repo::epel::testing {
  require yum
  class { 'yum::repodef::epel::testing': stage => 'yumsetup' }
}
