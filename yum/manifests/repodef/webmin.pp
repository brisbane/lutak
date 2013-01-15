# Class: yum::repodef::webmin
#
# This module manages Webmin repo files for $lsbdistrelease
#
class yum::repodef::webmin {
  require yum::repodef::base

  file { '/etc/yum.repos.d/webmin.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/webmin.repo",
  }
}
