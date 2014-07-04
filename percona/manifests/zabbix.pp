#
# = Class: percona::zabbix
#
# This module manages Percona MySQL monitoring for Zabbix
#
class percona::zabbix (
  $mysql_user     = 'percona_sensor',
  $mysql_pass     = 'secret',
  $mysql_host     = 'localhost',
  $mysql_port     = '3306',
  $mysql_ssl      = false,
  $mysql_ssl_key  = '/etc/pki/tls/certs/mysql/client-key.pem',
  $mysql_ssl_cert = '/etc/pki/tls/certs/mysql/client-cert.pem',
  $mysql_ssl_ca   = '/etc/pki/tls/certs/mysql/ca-cert.pem',
){

  include ::zabbix::agent

  # used in templates
  $local_dir_zabbix_agent_libdir = $::zabbix::agent::dir_zabbix_agent_libdir

  File {
    ensure  => file,
    owner   => root,
    group   => root,
    require => Package['zabbix-agent'],
    notify  => Service['zabbix-agent'],
  }

  file { "${::zabbix::agent::dir_zabbix_agentd_confd}/percona_mysql.conf":
    mode    => '0644',
    content => template('percona/zabbix/percona_mysql.conf.erb'),
  }

  file { "${::zabbix::agent::dir_zabbix_agent_libdir}/get_mysql_stats_wrapper.sh":
    mode    => '0755',
    content => template('percona/zabbix/get_mysql_stats_wrapper.sh.erb'),
  }

  file { "${::zabbix::agent::dir_zabbix_agent_libdir}/percona_get_mysql_stats.php":
    group   => 'zabbix',
    mode    => '0750',
    content => template('percona/zabbix/percona_get_mysql_stats.php.erb'),
  }




}
