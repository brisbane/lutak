# Class: yum::repo::srce::intern
#
# This module manages srce_intern repo files for $lsbdistrelease
#
class yum::repo::srce::intern {
  require yum
  class { 'yum::repodef::srce::intern': stage => 'yumsetup' }
}
