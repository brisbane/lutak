# Class: yumreposd::ius::archive
#
# This module adds IUS archive repo to $lsbdistrelease
#
class yumreposd::ius::archive {
  file {  '/etc/yum.repos.d/ius-archive.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/ius-archive.repo",
    require => Class['yumreposd::ius'],
  }
}
