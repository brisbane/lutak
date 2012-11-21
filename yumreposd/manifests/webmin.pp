# Class: yumreposd::webmin
#
# This module manages Webmin repo files for $lsbdistrelease
#
class yumreposd::webmin {
  file { '/etc/yum.repos.d/webmin.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/webmin.repo",
  }
}
