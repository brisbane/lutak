# Class: yum::repo::rpmforge
#
# This module manages Base repo files for $operatingsystemrelease
#
class yum::repo::rpmforge (
  $stage = 'yumsetup',
){
  require yum::repo::base

  file { '/etc/yum.repos.d/rpmforge.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/rpmforge.repo",
    require => Package['rpmforge-release'],
  }

  case $::operatingsystemrelease {
    default : {}
    /^5.*/: {
      package {'rpmforge-release':
        ensure   => '0.5.3-1.el5.rf',
        provider => 'rpm',
        source   => 'http://apt.sw.be/redhat/el5/en/i386/rpmforge/RPMS/rpmforge-release-0.5.3-1.el5.rf.i386.rpm',
      }
    }
    /^6.*/: {
      package {'rpmforge-release':
        ensure   => '0.5.3-1.el6.rf',
        provider => 'rpm',
        source   => 'http://apt.sw.be/redhat/el6/en/i386/rpmforge/RPMS/rpmforge-release-0.5.3-1.el6.rf.i686.rpm',
      }
    }
  }
}
