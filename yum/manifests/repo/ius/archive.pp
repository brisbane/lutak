# Class: yum::repo::ius::archive
#
# This module adds IUS archive repo to $lsbdistrelease
#
class yum::repo::ius::archive {
  include yum::repo::ius

  file {  '/etc/yum.repos.d/ius-archive.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/ius-archive.repo",
  }
  File['/etc/yum.repos.d/ius-archive.repo'] -> Package <| |>
}
