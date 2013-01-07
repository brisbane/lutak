# Class: ntp
#
# This module manages ntp and is standard for all hosts
#
# Requires:
#   $ntpServerList must be set in site manifest
#
# Sample Usage:
#   include ntp
#
class ntp (
  $package_name   = $ntp::params::client_package_name,
  $package_ensure = $ntp::params::package_ensure,
  $client_servers = $ntp::params::client_servers,
) inherits ntp::params {
  package { 'ntp':
    ensure  => $package_ensure,
    name    => $package_name,
  }
  service { 'ntpd':
    ensure  => running,
    enable  => true,
    require => Package['ntp'],
  }
  file { '/etc/ntp.conf':
    mode    => '0644',
    content => template('ntp/client-ntp.conf.erb'),
    notify  => Service['ntpd'],
    require => Package['ntp'],
  }
}
