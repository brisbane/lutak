# Class: zabbix::agent::megacli
#
# This module installs megacli zabbix plugin
#
class zabbix::agent::megacli {
  require yum::repo::srce::intern
  require yum::repo::srce

  package { 'zabbix-agentd_megacli':
    ensure   => present,
  }
}
