# Class: yum::repodef::atomic
#
# This module manages ATOMIC repo files for $operatingsystemrelease
#
class yum::repodef::atomic {
  require yum::repodef::base

  file { '/etc/yum.repos.d/atomic.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/atomic.repo",
    require => Package['atomic-release'],
  }

  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package { 'atomic-release' :
        ensure   => '1.0-14.el5.art',
        provider => 'rpm',
        source   => 'http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/atomic-release-1.0-14.el5.art.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'atomic-release' :
        ensure   => '1.0-14.el6.art',
        provider => 'rpm',
        source   => 'http://www6.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/atomic-release-1.0-14.el6.art.noarch.rpm',
      }
    }
  }
}