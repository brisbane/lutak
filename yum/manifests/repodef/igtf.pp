# Class: yum::repodef::igtf
#
# This module manages EGI IGTF repo
#
class yum::repodef::igtf {
  require yum::repodef::base

  file { '/etc/yum.repos.d/EGI-trustanchors.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/EGI-trustanchors.repo",
  }
}
