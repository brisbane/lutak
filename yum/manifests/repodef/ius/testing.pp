# Class: yum::repodef::ius::testing
#
# This module adds IUS testing repo to $lsbdistrelease
#
class yum::repodef::ius::testing {
  require yum::repodef::ius

  file {  '/etc/yum.repos.d/ius-testing.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/ius-testing.repo",
  }
}
