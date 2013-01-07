# Class: yum::repo::ius
#
# This module manages IUS repo files for $lsbdistrelease
#
class yum::repo::ius {
  require yum
  class { 'yum::repodef::ius': stage => 'yumsetup' }
}
