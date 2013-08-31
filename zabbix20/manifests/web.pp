# Class: zabbix20::web
#
# This module manages zabbix-web
#
class zabbix20::web (
  $package_ensure = $zabbix20::package_ensure,
  $major          = $zabbix20::major,
  $server_name    = $zabbix20::server_name,
  $server_active  = $zabbix20::server_active,
  $client_name    = $zabbix20::client_name,
  $db             = $zabbix20::db,
  $dbhost         = $zabbix20::dbhost,
  $dbname         = $zabbix20::dbname,
  $dbuser         = $zabbix20::dbuser,
  $dbpass         = $zabbix20::dbpass,
) inherits zabbix20 {
  include apache
  require php

  File {
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
  }

  package { "zabbix-web-${db}":
    ensure   => $package_ensure,
    name     => "zabbix${major}-web-${db}",
  }
  file { '/etc/httpd/conf.d/zabbix.conf':
    source  => 'puppet:///modules/zabbix20/zabbix.conf',
    require => Package["zabbix-web-${db}"],
  }

  file { '/etc/zabbix/web/zabbix.conf.php':
    owner   => root,
    group   => apache,
    mode    => '0640',
    content => template('zabbix20/zabbix.conf.php.erb'),
    require => Package["zabbix-web-${db}"],
  }

  file { '/etc/php.d/zabbix.ini':
    source  => 'puppet:///modules/zabbix20/zabbix.ini',
    require => Package['php'],
  }

}
