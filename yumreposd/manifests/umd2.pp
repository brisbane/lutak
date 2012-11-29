# Class: yumreposd::umd2
#
# This module manages UMD2 repo files
#
class yumreposd::umd2 {
  file { '/etc/yum.repos.d/UMD-2-base.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/UMD-2-base.repo",
    require => Package['umd-release'],
  }
  file { '/etc/yum.repos.d/UMD-2-updates.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/UMD-2-updates.repo",
    require => Package['umd-release'],
  }
  file { '/etc/yum.repos.d/UMD-2-testing.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/UMD-2-testing.repo",
    require => Package['umd-release'],
  }
  file { '/etc/yum.repos.d/UMD-2-untested.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/UMD-2-untested.repo",
    require => Package['umd-release'],
  }
  # CA packages
  file { '/etc/yum.repos.d/EGI-trustanchors.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/EGI-trustanchors.repo",
    require => Package['umd-release'],
  }


  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package {'umd-release':
        ensure   => '2.0.0-1.el5',
        provider => 'rpm',
        source   => 'http://repository.egi.eu/sw/production/umd/2/sl5/x86_64/base/umd-release-2.0.0-1.el5.noarch.rpm',
        require  => [ Package['yum-plugin-priorities'], Package['yum-plugin-protectbase'], ],
      }
    }
    /^6.*/: {
      package {'umd-release':
        ensure   => '2.0.0-1.el6',
        provider => 'rpm',
        source   => 'http://repository.egi.eu/sw/production/umd/2/sl6/x86_64/base/umd-release-2.0.0-1.el6.noarch.rpm',
        require  => [ Package['yum-plugin-priorities'], Package['yum-plugin-protectbase'], ],
      }
    }
  }
}
