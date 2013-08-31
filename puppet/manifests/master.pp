# Class: puppet::master
#
# This module manages puppet master
#
# Requires:
#   $puppetmaster must be set in
#

# Sample Usage:
#   include puppet
#
class puppet::master (
  $package_ensure     = $puppet::params::package_ensure,
  $fileserver_clients = $puppet::params::fileserver_clients,
  $server_type        = $puppet::params::server_type,
  $master_cert_name   = $puppet::master_cert_name,
  $cert_name          = $puppet::cert_name,
  $storeconfigs       = false,
  $dbadapter          = 'puppetdb',
  $dbname             = 'storeconfigs',
  $dbuser             = 'puppet',
  $dbpassword         = 'puppet',
  $dbserver           = 'localhost',
  $environments       = $puppet::params::environments,
  $envmanifest        = false,
  $modulepath         = '$confdir/environments/$environment/modules:$confdir/modules:/usr/share/puppet/modules',
  $report_age         = $puppet::report_age,
) inherits puppet {
  package { 'puppet-server':       ensure => $package_ensure, }
  package { 'rubygem-puppet-lint': ensure => $package_ensure, }

  # file defaults
  File {
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/puppet/fileserver.conf':
    content => template('puppet/fileserver.conf.erb'),
    require => Package['puppet-server'],
    notify  => Service['puppetmaster'],
  }

  # check if we use environments
  if $environments != [] {
    file { '/etc/puppet/environments':
      ensure  => directory,
      mode    => '0755',
      require => Package['puppet-server'],
    }
    puppet::environment { $environments : }
  }

  # puppet.conf template
  File['/etc/puppet/puppet.conf'] {
    content => template('puppet/puppet.conf-master.erb'),
    require => Package['puppet-server'],
    notify  => Service[$server_type],
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

      # rack application setup
      file { '/etc/puppet/rack':
        ensure  => directory,
        mode    => '0755',
      }
      file { '/etc/puppet/rack/config.ru':
        ensure  => file,
        owner   => puppet,
        source  => 'puppet:///modules/puppet/config.ru',
        require => [ File['/etc/puppet/rack'], Package['puppet-server'], ],
      }
      file { '/etc/puppet/rack/public':
        ensure  => directory,
        mode    => '0755',
        require => File['/etc/puppet/rack/config.ru'],
      }
      file { '/etc/puppet/rack/tmp':
        ensure  => directory,
        mode    => '0755',
        require => File['/etc/puppet/rack/config.ru'],
      }

      # plant apache conf file
      file { '/etc/httpd/conf.d/puppetmaster.conf':
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

  # storeconfigs
  if ( $storeconfigs =~ /true/ ) {
    case $dbadapter {
      default : { }
      /puppetdb/: { require puppet::puppetdb }
    }
  }

  # delete old reports
  tidy { 'delete_old_yaml_reports':
    path    => '/var/lib/puppet/reports',
    age     => $report_age,
    type    => 'mtime',
    recurse => true,
    matches => ['*.yaml'],
  }

}
