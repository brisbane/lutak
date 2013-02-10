# Class: yum::repo::igtf
#
# This module manages EGI IGTF repo
#
class yum::repo::igtf {
  require yum
  class { 'yum::repodef::igtf': stage => 'yumsetup' }
}
