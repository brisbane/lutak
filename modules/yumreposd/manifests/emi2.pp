# Class: yumreposd::emi2
#
# This module manages EMI2 repo files
#
class yumreposd::emi2 {
  file { '/etc/yum.repos.d/emi2-base.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/emi2-base.repo",
    require => [ Package['emi-release'], Class['yumreposd::base'] ],
  }
  file { '/etc/yum.repos.d/emi2-contribs.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/emi2-contribs.repo",
    require => Package['emi-release'],
  }
  file { '/etc/yum.repos.d/emi2-third-party.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/emi2-third-party.repo",
    require => Package['emi-release'],
  }
  file { '/etc/yum.repos.d/emi2-updates.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/emi2-updates.repo",
    require => Package['emi-release'],
  }
  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {}
    /^6.*/: {
      package {'emi-release':
        ensure   => '2.0.0-1.sl6',
        provider => 'rpm',
        source   => 'http://emisoft.web.cern.ch/emisoft/dist/EMI/2/sl6/x86_64/base/emi-release-2.0.0-1.sl6.noarch.rpm',
      }
    }
  }
  # CA packages
  file { '/etc/yum.repos.d/EGI-trustanchors.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/EGI-trustanchors.repo",
    require => Package['emi-release'],
  }
}
