# Class: puppet::puppetdb
#
# This module manages puppet puppetdb
#
# Requires:
#   $puppetpuppetdb must be set in
#

# Sample Usage:
#   include puppet::puppetdb
#
class puppet::puppetdb (
  $package_ensure  = $puppet::params::package_ensure,
  $puppetdb_server = 'puppet',
  $puppetdb_port   = '8081',
) inherits puppet {
  require yum::repo::srce::intern
  package { 'puppetdb': ensure => $package_ensure, }
  package { 'puppetdb-terminus': ensure => $package_ensure, }

  service { 'puppetdb':
    ensure  => running,
    enable  => true,
    require => Package['puppetdb'],
  }

  # file defaults
  File {
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[$puppet::server_type],
  }

  file { '/etc/puppet/routes.yaml':
    source => 'puppet:///modules/puppet/routes.yaml',
  }

  file { '/etc/puppet/puppetdb.conf':
    content => template('puppet/puppetdb.conf.erb'),
  }

}
