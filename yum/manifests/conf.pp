# Class: yum::conf
#
# This module manages yum packages
#
class yum::conf (
  $stage         = 'yumconf',
  $yum_proxy     = 'UNDEF',
  $purge_repos_d = true,
) {
  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {}
    /^6.*/: {
      file { '/etc/yum.conf' :
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template('yum/el6.yum.conf.erb'),
      }
    }
  }

  # base package
  package {'yum': ensure => present }

  # directory for repositories
  file { '/etc/yum.repos.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    purge   => $purge_repos_d,
    force   => true,
    require => Package['yum'],
  }

}
