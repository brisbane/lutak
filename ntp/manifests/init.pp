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
  $service_name   = $ntp::params::service_name,
  $ntpconf_path   = $ntp::params::ntpconf_path,
) inherits ntp::params {
  package { $package_name :
    ensure  => $package_ensure,
  }
  case $::osfamily {
    default : {}
    /(Debian|debian|Ubuntu|ubuntu)/: {
      package { 'ntpdate':
        ensure  => $package_ensure,
      }
    }
  }
  service { $service_name :
    ensure  => running,
    enable  => true,
    require => Package[$package_name],
  }
  file { $ntpconf_path :
    mode    => '0644',
    content => template('ntp/client-ntp.conf.erb'),
    notify  => Service[$service_name],
    require => Package[$package_name],
  }
}

