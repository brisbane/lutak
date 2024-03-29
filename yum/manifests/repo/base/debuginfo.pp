# Class: yum::repo::base::debuginfo
#
# This module manages Debuginfo repo files for $operatingsystemrelease
#

# CentOS
class yum::repo::base::debuginfo (
  $stage     = 'yumsetup',
  $priority  = '2',
  $exclude   = [],
  $include   = [],
  $debuginfo = false,
){
  require yum::repo::base

  case $::operatingsystem {
    default : {}
    'CentOS' : {
      file { '/etc/yum.repos.d/CentOS-Debuginfo.repo':
        ensure => file,
        mode   => '0644',
        owner  => root,
        group  => root,
        source => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/CentOS-Debuginfo.repo",
      }
    }
  }
}
