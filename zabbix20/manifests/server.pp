# Class: zabbix20::server
#
# This module manages zabbix-server
#
class zabbix20::server (
  $package_ensure            = $zabbix20::package_ensure,
  $major                     = $zabbix20::major,
  $listenip                  = '0.0.0.0',
  $db                        = $zabbix20::db,
  $dbhost                    = $zabbix20::dbhost,
  $dbname                    = $zabbix20::dbname,
  $dbuser                    = $zabbix20::dbuser,
  $dbpass                    = $zabbix20::dbpass,
  $dbsocket                  = $zabbix20::dbsocket,
  $dbsocket_path             = $zabbix20::dbsocket_path,
  $alert_scripts_path        = '/etc/zabbix/alert.d',
  $external_scripts          = '/etc/zabbix/externalscripts',
  $purge_conf_dir            = $zabbix20::purge_conf_dir,
) inherits zabbix20 {

  package { 'zabbix-server':
    ensure => $package_ensure,
    name   =>  "zabbix${major}-server-${db}",
  }
  service { 'zabbix-server':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['zabbix-server'],
  }

  file { '/etc/zabbix_server.conf':
    ensure  => file,
    owner   => zabbixsrv,
    group   => root,
    mode    => '0400',
    content => template('zabbix20/zabbix_server.conf.erb'),
    require => Package['zabbix-server'],
    notify  => Service['zabbix-server'],
  }
  file { '/etc/zabbix/server-conf.d':
    ensure  => directory,
    require => Package['zabbix-server'],
    recurse => $purge_conf_dir,
    purge   => $purge_conf_dir,
  }

  if $dbhost == 'localhost' {
    case $db {
      default : { }
      /^pg*|^postgre*/: {
        require postgresql::client
        require postgresql::server
        postgresql::server::db { $dbname:
          user     => $dbuser,
          password => $dbpass,
        }
      }
      /^mysql/: {
        require mysql::server
        mysql::db { $dbname:
          user     => $dbuser,
          password => $dbpass,
          host     => 'localhost',
          grant    => ['all'],
        }
      }
    }
  }

}
