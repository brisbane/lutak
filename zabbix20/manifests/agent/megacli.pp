# Class: zabbix20::agent::megacli
#
# This module installs zabbix megacli plugin
#
class zabbix20::agent::megacli {
  package { 'zabbix-agent_megacli':
    ensure   => present,
  }
}
