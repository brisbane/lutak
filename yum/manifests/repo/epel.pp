# Class: yum::repo::epel
#
# This module manages EPEL repo files for $lsbdistrelease
#
class yum::repo::epel {
  require yum
  class { 'yum::repodef::epel': stage => 'yumsetup' }
}
