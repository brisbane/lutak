# Class: zabbix::agent
#
# This module manages zabbix-agent
#
class zabbix::agent (
  $package_ensure = $zabbix::params::package_ensure,
  $server         = $zabbix::params::server,
) inherits zabbix::params {
  package { 'zabbix-agentd':
    ensure   => $package_ensure,
    require  => Class['yumreposd::srce'],
  }
  package { 'zabbix-agentd_ntpd':
    ensure   => $package_ensure,
    require  => Class['yumreposd::srce'],
  }
  package { 'zabbix-agentd_ssh':
    ensure   => $package_ensure,
    require  => Class['yumreposd::srce'],
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
