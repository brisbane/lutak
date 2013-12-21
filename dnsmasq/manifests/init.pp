#
# = Class: dnsmasq
#
# This modules installs and manages dnsmasq
#
class dnsmasq (
  $resolv_file      = '',
  $strict_order     = false,
  $no_resolv        = false,
  $no_poll          = false,
  $no_hosts         = false,
  $servers          = [],
  $cache_size       = undef,
  $bind_interfaces  = false,
  $interfaces       = [ 'lo' ],
  $listen_addresses = [ '127.0.0.1' ],
) {

  File {
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
  }

  package { 'dnsmasq':
    ensure => installed,
  }

  file { '/etc/dnsmasq.conf':
    content => template('dnsmasq/dnsmasq.conf.erb'),
    require => Package['dnsmasq'],
    notify  => Service['dnsmasq'],
  }

  service { 'dnsmasq':
    ensure  => running,
    enable  => true,
  }


}
