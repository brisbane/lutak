# Class: yumreposd::srce
#
# This module manages Srce repo files for $lsbdistrelease
#
class yumreposd::srce {
  file { '/etc/yum.repos.d/srce.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/srce.repo",
    require => [ Package['srce-release'], Class['yumreposd::base'] ],
  }

  # install package depending on major version
  case $::operatingsystemrelease {
    default : { }
    /^5.*/: {
      package { 'srce-release' :
        ensure   => present,
        provider => 'rpm',
        source   => 'http://ftp.srce.hr/srce-redhat/base/el5/x86_64/srce-release-5-3.el5.srce.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'srce-release' :
        ensure   => present,
        provider => 'rpm',
        source   => 'http://ftp.srce.hr/srce-redhat/base/el6/x86_64/srce-release-5-3.el6.srce.noarch.rpm', 
      }
    }
  }
}
