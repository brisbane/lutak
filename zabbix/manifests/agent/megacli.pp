# Class: zabbix::agent::megacli
#
# This module installs zabbix megacli plugin
#
class zabbix::agent::megacli {
  require yum::repo::srce
  require yum::repo::srce::intern

  package { 'zabbix-agentd_megacli':
    ensure   => present,
  }
}
