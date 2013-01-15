# Class: yum::repo::oscar
#
# This module manages OSCAR repo files for $lsbdistrelease
#
class yum::repo::oscar {
  require yum
  class { 'yum::repodef::oscar': stage => 'yumsetup' }
}
