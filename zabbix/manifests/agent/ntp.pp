#
# = Class: zabbix::agent::ntp
#
# This module installs zabbix ntp plugin
#
class zabbix::agent::ntp (
  $dir_zabbix_agentd_confd = $::zabbix::agent::dir_zabbix_agentd_confd,
) inherits zabbix::agent {

  file { "${dir_zabbix_agentd_confd}/ntp.conf" :
    ensure  => file,
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/zabbix/agent/ntp.conf',
    notify  => Service['zabbix-agent'],
  }

}
