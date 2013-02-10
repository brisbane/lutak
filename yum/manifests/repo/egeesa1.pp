# Class: yum::repo::egeesa1
#
# This module manages egeesa1 (SAM) repo files
#
class yum::repo::egeesa1 {
  require yum
  class { 'yum::repodef::egeesa1': stage => 'yumsetup' }
}
