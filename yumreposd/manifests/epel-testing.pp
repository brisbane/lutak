# Class: yumreposd::epel-testing
#
# This module manages EPEL testing repo files for $lsbdistrelease
#
class yumreposd::epel-testing {
  file { '/etc/yum.repos.d/epel-testing.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/epel-testing.repo",
    require => Class['yumreposd::epel'],
  }
}
