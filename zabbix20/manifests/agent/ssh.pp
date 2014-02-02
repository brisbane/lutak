# Class: zabbix20::agent::ssh
#
# This module installs zabbix ssh plugin
#
class zabbix20::agent::ssh {
  package { 'zabbix-agent_ssh':
    ensure   => present,
  }
}
