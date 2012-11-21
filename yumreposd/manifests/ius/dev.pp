# Class: yumreposd::ius::dev
#
# This module adds IUS dev repo to $lsbdistrelease
#
class yumreposd::ius::dev {
  file {  '/etc/yum.repos.d/ius-dev.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/ius-dev.repo",
    require => Class['yumreposd::ius'],
  }
}
