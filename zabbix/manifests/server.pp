# Class: zabbix::server
#
# This module manages zabbix-server
#
class zabbix::server (
  $package_ensure = $zabbix::package_ensure,
  $db             = $zabbix::db,
) inherits zabbix {
  require yum::repo::srce

  package { "zabbix-server-${db}":
    ensure   => $package_ensure,
  }
  service { 'zabbix-server':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package["zabbix-server-${db}"],
  }
}
