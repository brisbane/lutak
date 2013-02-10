# Class: yum::repo::gliteui
#
# This module manages gLite UI repo
#
class yum::repo::gliteui {
  require yum
  class { 'yum::repodef::gliteui': stage => 'yumsetup' }
}
