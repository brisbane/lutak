# Class: puppet
#
# This module manages puppet and is standard for all hosts
#
# Requires:
#   $puppetmaster must be set in hiera
#

# Sample Usage:
#   include puppet
#
class puppet (
  $package_ensure = $puppet::params::package_ensure,
  $puppetmaster   = $puppet::params::puppetmaster,
) inherits puppet::params {
  package { 'puppet':
    ensure  => $package_ensure,
  }
  service { 'puppet':
    ensure   => 'running',
    enable   => true,
    provider => 'redhat',
    require  => Package['puppet'],
  }
  file { '/etc/puppet/auth.conf':
    ensure  => present,
    source  => 'puppet:///modules/puppet/auth.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['puppet'],
    notify  => Service['puppet'],
  }
  file { '/etc/sysconfig/puppet':
    ensure  => present,
    content => template('puppet/sysconfigpuppet.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['puppet'],
    notify  => Service['puppet'],
  }
}
