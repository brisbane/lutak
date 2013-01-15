# Class: yum::repodef::oscar
#
# This module manages OSCAR repo files for $lsbdistrelease
#
class yum::repodef::oscar {
  require yum::repodef::base

  file { '/etc/yum.repos.d/oscar.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/oscar.repo",
  }
}
