# Class: haproxy
#
# This module manages HaProxy
#
class haproxy (
  $config_source  = 'puppet:///modules/haproxy/haproxy.cfg',
  $service_ensure = running,
  $service_enable = true,
  $noops          = undef,
) {

  package { 'haproxy': ensure => present, }

  file { '/etc/haproxy/haproxy.cfg':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => $config_source,
    require => Package['haproxy'],
  }

  service { 'haproxy':
    ensure    => $service_ensure,
    enable    => $service_enable,
    subscribe => File['/etc/haproxy/haproxy.cfg'],
  }

}
