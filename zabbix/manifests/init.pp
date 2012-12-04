# Class: zabbix
#
# This module manages zabbix
#
class zabbix (
  $package_ensure = $zabbix::params::package_ensure,
  $server_name    = $zabbix::params::server_name,
  $client_name    = $zabbix::params::client_name,
  $db             = $zabbix::params::db,
) inherits zabbix::params {
  package { 'zabbix':
    ensure => $package_ensure,
  }
}
