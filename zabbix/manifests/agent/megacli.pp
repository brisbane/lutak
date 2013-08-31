# Class: zabbix::agent::megacli
#
# This module installs zabbix megacli plugin
#
class zabbix::agent::megacli (
  $package_ensure = present
) {
  require ::yum::repo::srce::intern

  package { 'zabbix-agent_megacli':
    ensure   => $package_ensure,
  }
}
