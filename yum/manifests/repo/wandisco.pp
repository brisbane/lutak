# Class: yum::repo::wandisco
#
# This module manages Wandisco repo files for $lsbdistrelease
# Repo serves SVN 1.7
#
class yum::repo::wandisco {
  require yum
  class { 'yum::repodef::wandisco': stage => 'yumsetup' }
}
