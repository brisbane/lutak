# Class: yum::repodef::epel::testing
#
# This module manages EPEL testing repo files for $lsbdistrelease
#
class yum::repodef::epel::testing {
  require yum::repodef::epel

  file { '/etc/yum.repos.d/epel-testing.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/epel-testing.repo",
  }
}
