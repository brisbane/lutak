# Class: zabbix20::agent::mysql
#
# This module installs zabbix mysql sensor
#
class zabbix20::agent::mysql (
  $options = '',
){
  include zabbix20::agent

  package { 'zabbix-agent_mysql':
    ensure   => present,
  }

  file { '/etc/zabbix/agent-conf.d/mysql.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    content => template('zabbix20/agent/mysql.conf.erb'),
    require => Package['zabbix-agent_mysql'],
    notify  => Service['zabbix-agent'],
  }

}
