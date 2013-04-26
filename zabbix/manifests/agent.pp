# Class: zabbix::agent
#
# This module manages zabbix-agent
#
class zabbix::agent (
  $package_ensure = $zabbix::package_ensure,
  $server_name    = $zabbix::server_name,
  $client_name    = $zabbix::client_name,
) inherits zabbix {

  package { 'zabbix-agentd':
    ensure   => $package_ensure,
  }
  package { 'zabbix-agent_ntpd':
    ensure   => $package_ensure,
  }
  package { 'zabbix-agentd_ssh':
    ensure   => $package_ensure,
  }
  service { 'zabbix-agent':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['zabbix-agentd'],
  }
  file { '/etc/zabbix/zabbix_agentd.conf':
    ensure  => present,
    require => Package['zabbix-agentd'],
    content => template('zabbix/zabbix_agentd.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['zabbix-agent'],
  }
}
