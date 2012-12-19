# Class: yum::repo::emi2
#
# This module manages EMI2 repo files
#
class yum::repo::emi2 {
  require yum
  class { 'yum::repodef::emi2': stage => 'yumsetup' }
}
