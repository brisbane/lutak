# Class: zabbix::agent
#
# This module manages zabbix-agent
#
class zabbix::agent (
  $package_ensure = $zabbix::package_ensure,
  $server_name    = $zabbix::server_name,
  $client_name    = $zabbix::client_name,
  $pid_file       = $zabbix::pid_file,
) inherits zabbix {
  case $::operatingsystem {
    default : {
      $nameaddon = ''
      package { 'zabbix-agent':
        ensure   => $package_ensure,
      }
    }
    'CentOS' : {
      $nameaddon = 'd'
      package { 'zabbix-agentd':
        ensure   => $package_ensure,
      }
      package { 'zabbix-agent_ntpd':
        ensure   => $package_ensure,
      }
      package { 'zabbix-agentd_ssh':
        ensure   => $package_ensure,
      }
      file { '/etc/zabbix/zabbix_agentd.conf':
        ensure  => present,
        require => Package["zabbix-agent${nameaddon}"],
        content => template('zabbix/zabbix_agentd.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['zabbix-agent'],
      }
    }
    'Fedora' : {
      $nameaddon = ''
      package { 'zabbix-agent':
        ensure   => $package_ensure,
      }
      file { '/etc/zabbix_agentd.conf':
        ensure  => present,
        require => Package["zabbix-agent${nameaddon}"],
        content => template('zabbix/zabbix_agentd.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['zabbix-agent'],
      }
    }
  }

  service { 'zabbix-agent':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package["zabbix-agent${nameaddon}"],
  }
}
