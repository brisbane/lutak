# Class: yum::repo::fhgfs
#
# This module manages FhGFS repo files for $lsbdistrelease
#
class yum::repo::fhgfs {
  require yum
  class { 'yum::repodef::fhgfs': stage => 'yumsetup' }
}
