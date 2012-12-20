# Class: zabbix::web
#
# This module manages zabbix-web
#
class zabbix::web (
  $package_ensure = $zabbix::package_ensure,
  $db             = $zabbix::db,
) inherits zabbix {
  require apache
  require yum::repo::srce

  include php

  package { "zabbix-web-${db}":
    ensure   => $package_ensure,
  }
  file { '/etc/httpd/conf.d/zabbix.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/zabbix/zabbix.conf',
    require => Package["zabbix-web-${db}"],
  }
}
