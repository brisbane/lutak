# Class: zabbix20::agent
#
# This module manages zabbix-agent
#
class zabbix20::agent (
  $package_ensure = $zabbix20::package_ensure,
  $major          = $zabbix20::major,
  $server_name    = $zabbix20::server_name,
  $server_active  = $zabbix20::server_active,
  $client_name    = $zabbix20::client_name,
  $timeout        = '3',
  $purge_conf_dir = $zabbix20::purge_conf_dir,
) inherits zabbix20 {

  File {
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['zabbix-agent'],
    notify  => Service['zabbix-agent'],
  }

  package { 'zabbix-agent':
    ensure   => $package_ensure,
    name     => "zabbix${major}-agent",
  }
  service { 'zabbix-agent':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['zabbix-agent'],
  }
  file { '/etc/zabbix_agentd.conf':
    content => template('zabbix20/zabbix_agentd.conf.erb'),
  }
  file { '/etc/zabbix/agent-conf.d':
    ensure  => directory,
    recurse => $purge_conf_dir,
    purge   => $purge_conf_dir,
  }

  file { '/etc/sudoers.d/zabbix_notty':
    mode    => '0440',
    content => "Defaults:zabbix !requiretty\n",
  }

}
