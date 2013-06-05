# Class: yum::repo::atomic
#
# This module manages ATOMIC repo files for $operatingsystemrelease
#
class yum::repo::atomic (
  $stage    = 'yumsetup',
  $priority = '21',
  $exclude  = [ 'php*' ],
) {
  require yum::repo::base

  file { '/etc/yum.repos.d/atomic.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/atomic.erb"),
    require => Package['atomic-release'],
  }

  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package { 'atomic-release' :
        ensure   => '1.0-16.el5.art',
        provider => 'rpm',
        source   => 'http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/atomic-release-1.0-16.el5.art.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'atomic-release' :
        ensure   => '1.0-16.el6.art',
        provider => 'rpm',
        source   => 'http://www6.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/atomic-release-1.0-16.el6.art.noarch.rpm',
      }
    }
  }
}
