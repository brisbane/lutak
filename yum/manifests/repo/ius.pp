# Class: yum::repo::ius
#
# This module manages IUS repo files for $lsbdistrelease
#
class yum::repo::ius (
  $stage = 'yumsetup'
){
  require yum::repo::base

  file {  '/etc/yum.repos.d/ius.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/ius.repo",
    require => Package['ius-release'],
  }

  # install package depending on major version
  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package { 'ius-release':
        ensure   => '1.0-10.ius.el5',
        provider => 'rpm',
        source   =>  'http://dl.iuscommunity.org/pub/ius/stable/Redhat/5/x86_64/ius-release-1.0-10.ius.el5.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'ius-release':
        ensure   => '1.0-10.ius.el6',
        provider => 'rpm',
        source   =>  'http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/ius-release-1.0-10.ius.el6.noarch.rpm',
      }
    }
  }
}
