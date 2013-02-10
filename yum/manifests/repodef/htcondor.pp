# Class: yum::repodef::htcondor
#
# This module manages HTCondor repo files for $lsbdistrelease
#
class yum::repodef::htcondor {
  require yum::repodef::base

  file { '/etc/yum.repos.d/htcondor.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/htcondor.repo",
  }
}
