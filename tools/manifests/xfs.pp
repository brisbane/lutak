# Class: admintools::xfs
#
# This module manages XFS
#
class tools::xfs {
  package { 'xfsdump':
    ensure => present,
  }
}
