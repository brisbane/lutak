# Class: yumreposd
#
# This module manages repo files
#
class yumreposd {
  package {'yum':
    ensure => present,
  }
  file {'/etc/yum.repos.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    purge   => true,
    force   => true,
    require => Package['yum'],
  }
}
