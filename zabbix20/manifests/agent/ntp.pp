# Class: zabbix20::agent::ntp
#
# This module installs zabbix ntp plugin
#
class zabbix20::agent::ntp {
  package { 'zabbix-agent_ntpd':
    ensure   => present,
  }
}
