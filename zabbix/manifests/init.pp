# Class: zabbix
#
# This module manages zabbix
#
class zabbix (
  $package_ensure = $zabbix::params::package_ensure,
) inherits zabbix::params {
  package { 'zabbix':
    ensure => $package_ensure,
  }
}
