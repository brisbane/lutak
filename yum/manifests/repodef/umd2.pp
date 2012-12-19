# Class: yum::repodef::umd2
#
# This module manages UMD2 repo files
#
class yum::repodef::umd2 {
  require yum::repodef::base

  file { '/etc/yum.repos.d/UMD-2-base.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/UMD-2-base.repo",
    require => Package['umd-release'],
  }

  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package {'umd-release':
        ensure   => '2.0.0-1.el5',
        provider => 'rpm',
        source   => 'http://repository.egi.eu/sw/production/umd/2/sl5/x86_64/base/umd-release-2.0.0-1.el5.noarch.rpm',
      }
    }
    /^6.*/: {
      package {'umd-release':
        ensure   => '2.0.0-1.el6',
        provider => 'rpm',
        source   => 'http://repository.egi.eu/sw/production/umd/2/sl6/x86_64/base/umd-release-2.0.0-1.el6.noarch.rpm',
      }
    }
  }
}
