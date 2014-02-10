# Class: puppet
#
# This module manages puppet and is standard for all hosts
#
# Requires:
#   $puppetmaster must be set in
#

# Sample Usage:
#   include puppet
#
class puppet (
  $package_ensure   = $puppet::params::package_ensure,
  $service          = $puppet::params::service,
  $puppetmaster     = $puppet::params::puppetmaster,
  $master_cert_name = $puppet::params::master_cert_name,
  $cert_name        = $puppet::params::cert_name,
  $agentenv         = $puppet::params::agentenv,
  $report_age       = $puppet::params::report_age,
  $modulepath       = $puppet::params::modulepath,
) inherits puppet::params {
  # file defaults
  File {
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['puppet'],
  }

  # package and service
  package { 'puppet':
    ensure  => $package_ensure,
  }

  service { $service :
    ensure  => 'running',
    enable  => true,
    require => File['/etc/puppet/puppet.conf'],
  }

  # files
  file { '/etc/puppet/puppet.conf': content => template('puppet/puppet.conf.erb'), }

  case $::osfamily {
    /(RedHat|redhat)/: {
      file { '/etc/puppet/auth.conf':   source  => 'puppet:///modules/puppet/auth.conf', }
      file { '/etc/sysconfig/puppet':   content => template('puppet/sysconfigpuppet.erb'), }
    }
    /(Debian|debian|Ubuntu|ubuntu)/: {
      file { '/etc/default/puppet':   content => template('puppet/defaultpuppet.erb'), }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat and Debian")
    }
  }

}
