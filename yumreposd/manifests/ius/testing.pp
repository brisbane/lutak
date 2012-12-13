# Class: yumreposd::ius::testing
#
# This module adds IUS testing repo to $lsbdistrelease
#
class yumreposd::ius::testing {
  file {  '/etc/yum.repos.d/ius-testing.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/ius-testing.repo",
    require => Class['yumreposd::ius'],
  }
}
