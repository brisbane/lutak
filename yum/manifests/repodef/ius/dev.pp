# Class: yum::repodef::ius::dev
#
# This module adds IUS dev repo to $lsbdistrelease
#
class yum::repodef::ius::dev {
  require yum::repodef::ius

  file {  '/etc/yum.repos.d/ius-dev.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/ius-dev.repo",
  }
}
