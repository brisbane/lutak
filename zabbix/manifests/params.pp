# Class: zabbix::params
#
# This module contains defaults for zabbix modules
#
class zabbix::params {
  $package_ensure  = 'present'
  $server_name     = 'mon'
  $client_name     = $::fqdn
}
