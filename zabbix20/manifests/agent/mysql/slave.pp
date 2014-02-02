# Class: zabbix20::agent::mysql::slave
#
# This module installs zabbix mysql slave sensor
#
class zabbix20::agent::mysql::slave (
  $options = '',
){

  include zabbix20::agent

  package { 'zabbix-agent_mysql-slave':
    ensure   => present,
  }

  file { '/etc/zabbix/agent-conf.d/mysql-slave.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    content => template('zabbix20/agent/mysql-slave.conf.erb'),
    require => Package['zabbix-agent_mysql-slave'],
    notify  => Service['zabbix-agent'],
  }

}
