# Class: yum::repodef::puppetlabls
#
# This module manages PuppetLabs repo files for $lsbdistrelease
#
class yum::repodef::gluster {
  require yum::repodef::base

  file { '/etc/yum.repos.d/gluster.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/gluster.repo",
  }
}
