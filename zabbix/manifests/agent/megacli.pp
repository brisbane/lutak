# Class: zabbix::agent::megacli
#
# This module installs zabbix megacli plugin
#
class zabbix::agent::megacli {
  package { 'zabbix-agentd_megacli':
    ensure   => present,
  }
}
