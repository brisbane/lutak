# Class: yumreposd::rpmforge
#
# This module manages Base repo files for $operatingsystemrelease
#
class yumreposd::rpmforge {
  file { '/etc/yum.repos.d/rpmforge.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/rpmforge.repo",
    require => [ Package['rpmforge-release'], Class['yumreposd::base'] ],
  }
  file { '/etc/yum.repos.d/mirrors-rpmforge' :
    ensure  => absent,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/mirrors/mirrors-rpmforge",
    require => Package['rpmforge-release'],
  }
  file { '/etc/yum.repos.d/mirrors-rpmforge-extras' :
    ensure  => absent,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/mirrors/mirrors-rpmforge-extras",
    require => Package['rpmforge-release'],
  }
  file { '/etc/yum.repos.d/mirrors-rpmforge-testing' :
    ensure  => absent,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/mirrors/mirrors-rpmforge-testing",
    require => Package['rpmforge-release'],
  }
  case $::operatingsystemrelease {
    default : {}
    /^5.*/: {
      package {'rpmforge-release':
        ensure   => '0.5.2-2.el5.rf',
        provider => 'rpm',
        source   => 'http://apt.sw.be/redhat/el5/en/i386/rpmforge/RPMS/rpmforge-release-0.5.2-2.el5.rf.i386.rpm',
      }
    }
    /^6.*/: {
      package {'rpmforge-release':
        ensure   => '0.5.2-2.el6.rf',
        provider => 'rpm',
        source   => 'http://apt.sw.be/redhat/el6/en/i386/rpmforge/RPMS/rpmforge-release-0.5.2-2.el6.rf.i686.rpm',
      }
    }
  }
}
