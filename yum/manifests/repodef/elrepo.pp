# Class: yum::repodef::elrepo
#
# This module manages elrepo repo files for $operatingsystemrelease
#
class yum::repodef::elrepo {
  require yum::repodef::base

  file { '/etc/yum.repos.d/elrepo.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/elrepo.repo",
    require => Package['elrepo-release'],
  }

  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package { 'elrepo-release' :
        ensure   => '5-3.el5.elrepo',
        provider => 'rpm',
        source   => 'http://elrepo.org/elrepo-release-5-3.el5.elrepo.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'elrepo-release' :
        ensure   => '6-5.el6.elrepo',
        provider => 'rpm',
        source   => 'http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm',
      }
    }
  }
}
