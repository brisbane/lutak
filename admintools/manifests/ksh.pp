# Class: admintools::ksh
#
# This module manages XFS
#
class admintools::ksh {

  package { 'ksh': ensure => present, }
  file { '/usr/bin/ksh':
    ensure => link,
    target => '/bin/ksh',
  }

}
