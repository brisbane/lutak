# Class: yum::repo::ius::dev
#
# This module adds IUS dev repo to $lsbdistrelease
#
class yum::repo::ius::dev {
  include yum::repo::ius

  file {  '/etc/yum.repos.d/ius-dev.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/ius-dev.repo",
  }
  File['/etc/yum.repos.d/ius-dev.repo'] -> Package <| |>
}
