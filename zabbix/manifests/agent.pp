#
# Class: zabbix::agent
#
# This module manages zabbix-agent
#
class zabbix::agent (
  $package                 = $::zabbix::params::agent_package,
  $version                 = $::zabbix::params::agent_version,
  $service                 = $::zabbix::params::agent_service,
  $status                  = $::zabbix::params::agent_status,
  $file_owner              = $::zabbix::params::agent_file_owner,
  $file_group              = $::zabbix::params::agent_file_group,
  $file_mode               = $::zabbix::params::agent_file_mode,
  $purge_conf_dir          = $::zabbix::params::agent_purge_conf_dir,
  $file_zabbix_agentd_conf = $::zabbix::params::file_zabbix_agentd_conf,
  $dir_zabbix_agentd_confd = $::zabbix::params::dir_zabbix_agentd_confd,
  $zabbix_agentd_logfile   = $::zabbix::params::zabbix_agentd_logfile,
  $server_name             = 'mon',
  $server_active           = 'mon',
  $client_name             = $::hostname,
  $timeout                 = '30',
) inherits zabbix::params {

  File {
    ensure  => file,
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
    require => Package[$package],
    notify  => Service[$service],
  }

  package { 'zabbix-agent':
    ensure   => $version,
    name     => $package,
  }

  service { 'zabbix-agent':
    ensure   => running,
    name     => $service,
    enable   => true,
    require  => Package[$package],
  }

  file { 'zabbix_agentd.conf':
    path    => $file_zabbix_agentd_conf,
    content => template('zabbix/zabbix_agentd.conf.erb'),
  }

  file { 'zabbix_agent_confd':
    ensure  => directory,
    path    => $dir_zabbix_agentd_confd,
    recurse => $purge_conf_dir,
    purge   => $purge_conf_dir,
  }

  file { '/etc/sudoers.d/zabbix_notty':
    mode    => '0440',
    content => "Defaults:zabbix !requiretty\n",
  }

  # compatibilty needed for zabbix agent sensors (sudoers)
  group { 'zabbix':
    require => Package['zabbix-agent'],
  }

  user { 'zabbix':
    require => Package['zabbix-agent'],
  }


}
