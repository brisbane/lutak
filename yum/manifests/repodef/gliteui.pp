# Class: yum::repodef::gliteui
#
# This module manages gLite UI repo
#
class yum::repodef::gliteui {
  require yum::repodef::base

  file { '/etc/yum.repos.d/glite-UI.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/glite-UI.repo",
  }
}
