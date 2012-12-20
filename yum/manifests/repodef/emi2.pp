# Class: yum::repodef::emi2
#
# This module manages EMI2 repo files
#
class yum::repodef::emi2 {
  require yum::repodef::base

  file { '/etc/yum.repos.d/emi2-base.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/emi2-base.repo",
  }
}
