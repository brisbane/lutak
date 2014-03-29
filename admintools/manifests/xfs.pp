# Class: admintools::xfs
#
# This module manages XFS
#
class admintools::xfs {

  package { 'xfsdump': ensure => present, }

}
