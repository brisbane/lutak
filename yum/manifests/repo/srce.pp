# Class: yum::repo::srce
#
# This module manages Srce repo files for $lsbdistrelease
#
class yum::repo::srce {
  require yum
  class { 'yum::repodef::srce': stage => 'yumsetup' }
}
