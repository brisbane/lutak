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
  $server_type        = $puppet::params::server_type,
) inherits puppet::params {
  package { 'puppet-server':       ensure => $package_ensure,  }
  package { 'rubygem-puppet-lint': ensure => $package_ensure, }

  file { '/etc/puppet/fileserver.conf':
    ensure  => present,
    content => template('puppet/fileserver.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['puppet-server'],
    notify  => Service['puppetmaster'],
  }


  # install package depending on major version
  case $server_type {
    default : {
      service { 'puppetmaster':
        ensure   => 'running',
        enable   => true,
        provider => 'redhat',
        require  => Package['puppet-server'],
      }
    }
    /^httpd|^apache/: {
      # include and set up apache
      include apache
      include apache::mod::ssl
      include apache::mod::passenger

      # puppet.conf with SSL settings
      file { '/etc/puppet/puppet.conf':
        ensure  => present,
        content => template('puppet/puppet.conf.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package['puppet-server'],
      }

      # rack application setup
      file { '/etc/puppet/rack':
        ensure  => directory,
        owner   => root,
        group   => root,
        mode    => '0755',
      }
      file { '/etc/puppet/rack/config.ru':
        ensure  => file,
        owner   => puppet,
        group   => root,
        mode    => '0644',
        source  => 'puppet:///modules/puppet/config.ru',
        require => [ File['/etc/puppet/rack'], Package['puppet-server'], ],
      }
      file { '/etc/puppet/rack/public':
        ensure  => directory,
        owner   => root,
        group   => root,
        mode    => '0755',
        require => File['/etc/puppet/rack/config.ru'],
      }
      file { '/etc/puppet/rack/tmp':
        ensure  => directory,
        owner   => root,
        group   => root,
        mode    => '0755',
        require => File['/etc/puppet/rack/config.ru'],
      }

      # plant apache conf file
      file { '/etc/httpd/conf.d/puppetmaster.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('puppet/puppetmaster.conf.erb'),
        require => File['/etc/puppet/rack/tmp'],
      }

      # disable puppetmaster service & restart httpd
      service { 'puppetmaster':
        ensure   => 'stopped',
        enable   => false,
        provider => 'redhat',
        require  => [ Package['puppet-server'], File['/etc/httpd/conf.d/puppetmaster.conf'], ],
        notify   => Service['httpd'],
      }
    }
    /^nginx/: {
      # TODO: nginx configuration
    }
  }
}
