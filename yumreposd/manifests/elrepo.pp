# Class: yumreposd::elrepo
#
# This module manages elrepo repo files for $operatingsystemrelease
#
class yumreposd::elrepo {
  file { '/etc/yum.repos.d/elrepo.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/elrepo.repo",
    require => [ Package['elrepo-release'], Class['yumreposd::base'] ],
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
        ensure   => '6-4.el6.elrepo',
        provider => 'rpm',
        source   => 'http://elrepo.org/elrepo-release-6-4.el6.elrepo.noarch.rpm',
      }
    }
  }
}
