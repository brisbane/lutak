# Class: yum::repo::htcondor
#
# This module manages HTCondor repo files for $lsbdistrelease
#
class yum::repo::htcondor {
  require yum
  class { 'yum::repodef::htcondor': stage => 'yumsetup' }
}
