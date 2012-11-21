# Class: zabbix::params
#
# This module contains defaults for zabbix modules
#
class zabbix::params {
  $package_ensure = 'present'
  $server         = 'mon'
}
