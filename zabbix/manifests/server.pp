#
# Class: zabbix::server
#
# This module manages zabbix-server
#
class zabbix::server (
  $package                 = $::zabbix::params::server_package,
  $version                 = $::zabbix::params::server_version,
  $service                 = $::zabbix::params::server_service,
  $status                  = $::zabbix::params::server_status,
  $file_owner              = $::zabbix::params::server_file_owner,
  $file_group              = $::zabbix::params::server_file_group,
  $file_mode               = $::zabbix::params::server_file_mode,
  $purge_conf_dir          = $::zabbix::params::server_purge_conf_dir,
  $file_zabbix_server_conf = $::zabbix::params::file_zabbix_server_conf,
  $dir_zabbix_server_confd = $::zabbix::params::dir_zabbix_server_confd,
  $listenip                = '0.0.0.0',
  $create_db               = false,
  $db                      = 'pgsql',
  $dbhost                  = 'localhost',
  $dbname                  = 'zabbix',
  $dbuser                  = 'zabbix',
  $dbpass                  = 'secret',
  $dbsocket                = false,
  $dbsocket_path           = '/var/lib/mysql/mysql.sock',
  $alert_scripts_path      = $::zabbix::params::alert_scripts_path,
  $external_scripts        = $::zabbix::params::external_scripts,
) inherits zabbix::params {

  File {
    ensure  => file,
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
    require => Package[$package],
    notify  => Service[$service],
  }

  package { 'zabbix-server':
    ensure => $version,
    name   => "${package}-${db}",
  }

  service { 'zabbix-server':
    ensure   => running,
    name     => $service,
    enable   => true,
    require  => Package['zabbix-server'],
  }

  file { 'zabbix_server.conf':
    path    => $file_zabbix_server_conf,
    mode    => '0640',
    content => template('zabbix/zabbix_server.conf.erb'),
    require => Package['zabbix-server'],
    notify  => Service['zabbix-server'],
  }

  file { '/etc/zabbix/zabbix_server.d':
    ensure  => directory,
    path    => $dir_zabbix_server_confd,
    recurse => $purge_conf_dir,
    purge   => $purge_conf_dir,
  }

  if $dbhost == 'localhost' and $create_db == true {
    case $db {
      default : { }
      'pgsql': {
        include ::postgresql::client
        include ::postgresql::server
        ::postgresql::server::db { $dbname:
          user     => $dbuser,
          password => postgresql_password($dbuser,$dbpass),
        }
        ::postgresql::server::pg_hba_rule { 'zabbix_localhost':
          type        => 'host',
          database    => 'zabbix',
          user        => 'zabbix',
          auth_method => 'md5',
          address     => '127.0.0.1/32',
          description => 'Allow access to zabbix database to user zabbix from localhost',
        }
      }
      'mysql': {
        include ::mysql::client
        include ::mysql::server
        ::mysql::db { $dbname:
          user     => $dbuser,
          password => $dbpass,
          host     => 'localhost',
          grant    => ['all'],
        }
      }
    }
  }


}
