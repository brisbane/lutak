# Class: admintools::xvfb
#
# This module manages Xvfb for xorg
#
class admintools::xvfb {

  package { 'xorg-x11-server-Xvfb': ensure => present, }

  file { '/etc/sysconfig/xvfb':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/admintools/xvfb-sysconfig',
  }

  file { '/etc/rc.d/init.d/xvfb':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///modules/admintools/xvfb-init',
  }

  service { 'xvfb':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/sysconfig/xvfb'],
    require   => [
      Package['xorg-x11-server-Xvfb'],
      File['/etc/rc.d/init.d/xvfb'],
    ],
  }

}
