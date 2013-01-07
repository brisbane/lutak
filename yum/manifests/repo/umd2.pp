# Class: yum::repo::umd2
#
# This module manages UMD2 repo files
#
class yum::repo::umd2 {
  require yum
  class { 'yum::repodef::umd2': stage => 'yumsetup' }
}
