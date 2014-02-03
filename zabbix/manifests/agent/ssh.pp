#
# = Class: zabbix::agent::ssh
#
# This module installs zabbix ssh plugin
#
class zabbix::agent::ssh (
  $options                 = '',
  $dir_zabbix_agentd_confd = $::zabbix::agent::dir_zabbix_agentd_confd,
) inherits zabbix::agent {

  ::sudoers::allowed_command { 'zabbix_ssh':
    command          => '/usr/sbin/lsof -i -n -l -P',
    user             => 'zabbix',
    require_password => false,
    comment          => 'Zabbix sensor for monitoring SSH.',
  }

  file { "${dir_zabbix_agentd_confd}/ssh.conf" :
    ensure  => file,
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/zabbix/agent/ssh.conf',
    notify  => Service['zabbix-agent'],
    require => ::Sudoers::Allowed_command['zabbix_ssh'],
  }

}
