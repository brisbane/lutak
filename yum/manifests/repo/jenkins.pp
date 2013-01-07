# Class: yum::repo::jenkins
#
# This module manages Jenkins repo files for $lsbdistrelease
#
class yum::repo::jenkins {
  class { 'yum::repodef::jenkins': stage => 'yumsetup' }
}
