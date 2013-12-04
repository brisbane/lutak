# Class: zabbix20
#
# This module manages zabbix
#
class zabbix20 (
  $package_ensure = $zabbix20::params::package_ensure,
  $major          = $zabbix20::params::major,
  $server_name    = $zabbix20::params::server_name,
  $server_active  = $zabbix20::params::server_active,
  $client_name    = $zabbix20::params::client_name,
  $db             = $zabbix20::params::db,
  $dbhost         = $zabbix20::params::dbhost,
  $dbname         = $zabbix20::params::dbname,
  $dbuser         = $zabbix20::params::dbuser,
  $dbpass         = $zabbix20::params::dbpass,
  $dbsocket       = $zabbix20::params::dbsocket,
  $dbsocket_path  = $zabbix20::params::dbsocket_path,
  $purge_conf_dir = $zabbix20::params::purge_conf_dir,
) inherits zabbix20::params {
  package { 'zabbix':
    ensure => $package_ensure,
    name   => "zabbix${major}",
  }
}
