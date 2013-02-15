# Class: zabbix20::agent::megacli
#
# This module installs zabbix megacli plugin
#
class zabbix20::agent::megacli {
  package { 'zabbix-agentd_megacli':
    ensure   => present,
  }
}
