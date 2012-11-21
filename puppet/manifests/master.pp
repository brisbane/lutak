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
class puppet::master (
  $package_ensure     = $puppet::params::package_ensure,
  $fileserver_clients = $puppet::params::fileserver_clients,
) inherits puppet::params {
  package { 'puppet-server':
    ensure  => $package_ensure,
  }
  service { 'puppetmaster':
    ensure   => 'running',
    enable   => true,
    provider => 'redhat',
    require  => Package['puppet-server'],
  }
  file { '/etc/puppet/fileserver.conf':
    ensure  => present,
    content => template('puppet/fileserver.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['puppet-server'],
    notify  => Service['puppetmaster'],
  }
}
