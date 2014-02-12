#
# = Class: desktop::networkmanager
#
# This module installs NetworkManager
#
class desktop::networkmanager {

  package { 'NetworkManager': ensure => present, }

  file { '/etc/NetworkManager/NetworkManager.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/desktop/networkmanager/NetworkManager.conf',
    require => Package['NetworkManager'],
  }

  service { 'NetworkManager':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/NetworkManager/NetworkManager.conf'],
  }

}
