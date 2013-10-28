# Class: zabbix20::server
#
# This module manages zabbix-server
#
class zabbix20::server (
  $package_ensure = $zabbix20::package_ensure,
  $major          = $zabbix20::major,
  $listenip       = '0.0.0.0',
  $db             = $zabbix20::db,
  $dbhost         = $zabbix20::dbhost,
  $dbname         = $zabbix20::dbname,
  $dbuser         = $zabbix20::dbuser,
  $dbpass         = $zabbix20::dbpass,
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
    group   => zabbix,
    mode    => '0400',
    content => template('zabbix20/zabbix_server.conf.erb'),
    require => Package['zabbix-server'],
    notify  => Service['zabbix-server'],
  }

  if $dbhost == 'localhost' {
    case $db {
      default : { }
      /^pg*|^postgre*/: {
        require postgresql::client
        require postgresql::server
        postgresql::db { $dbname:
          user     => $dbuser,
          password => $dbpass,
        }
      }
      /^mysql/: {
      }
    }
  }

}
