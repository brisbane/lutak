# Class: yum::repo::webmin
#
# This module manages Webmin repo files for $lsbdistrelease
#
class yum::repo::webmin (
  $stage = 'yumsetup',
){
  require yum::repo::base

  exec {'webminrepokeyimport':
    command => '/bin/rpm --import http://www.webmin.com/jcameron-key.asc',
    unless  => 'rpm -qa | grep 11f63c51 > /dev/null',
  }

  file { '/etc/yum.repos.d/webmin.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/webmin.repo",
    require => Exec['webminrepokeyimport'],
  }
}
