#
# Class: zabbix::params
#
# This module contains defaults for other zabbix modules
#
class zabbix::params {

  # general zabbix settings
  $ensure         = 'present'
  $server_name    = 'mon'
  $server_active  = 'mon'
  $client_name    = $::fqdn

  # module specific settings (agent)
  $agent_file_owner     = 'root'
  $agent_file_group     = 'root'
  $agent_file_mode      = '0644'
  $agent_purge_conf_dir = false

  # module specific settings (proxy)
  $proxy_file_owner     = 'root'
  $proxy_file_group     = 'root'
  $proxy_file_mode      = '0644'
  $proxy_purge_conf_dir = false

  # module specific settings (server)
  $server_file_owner     = 'root'
  $server_file_group     = 'root'
  $server_file_mode      = '0644'
  $server_purge_conf_dir = false

  # module dependencies
  $dependency_class = 'tsm::dependency'
  $my_class         = undef

  # install package depending on major version
  case $::osfamily {
    default: {
      $agent_package            = 'zabbix-agent'
      $agent_version            = 'present'
      $agent_service            = 'zabbix-agent'
      $agent_status             = 'enabled'
      $file_zabbix_agentd_conf  = '/etc/zabbix/zabbix_agentd.conf'
      $dir_zabbix_agentd_confd  = '/etc/zabbix/zabbix_agentd.d'
      $server_package           = 'zabbix-server'
      $server_version           = 'present'
      $server_service           = 'zabbix-server'
      $server_status            = 'enabled'
      $alert_scripts_path       = '/var/lib/zabbixsrv/alertscripts'
      $file_zabbix_server_conf  = '/etc/zabbix/zabbix_server.conf'
      $dir_zabbix_server_confd  = '/etc/zabbix/zabbix_server.d'
      $external_scripts         = '/var/lib/zabbixsrv/externalscripts'
      $proxy_package            = 'zabbix-proxy'
      $proxy_version            = 'present'
      $proxy_service            = 'zabbix-proxy'
      $proxy_status             = 'enabled'
      $web_package              = 'zabbix-web'
      $web_version              = 'present'
      $web_file_owner           = 'root'
      $web_file_group           = 'root'
      $web_file_mode            = '0640'
      $web_dir_zabbix_php       = '/etc/zabbix/web'
    }
    /(RedHat|redhat|amazon)/: {
      $agent_package            = 'zabbix-agent'
      $agent_version            = 'present'
      $agent_service            = 'zabbix-agent'
      $agent_status             = 'enabled'
      $file_zabbix_agentd_conf  = '/etc/zabbix/zabbix_agentd.conf'
      $dir_zabbix_agentd_confd  = '/etc/zabbix/zabbix_agentd.d'
      $server_package           = 'zabbix-server'
      $server_version           = 'present'
      $server_service           = 'zabbix-server'
      $server_status            = 'enabled'
      $alert_scripts_path       = '/var/lib/zabbixsrv/alertscripts'
      $external_scripts         = '/var/lib/zabbixsrv/externalscripts'
      $file_zabbix_server_conf  = '/etc/zabbix/zabbix_server.conf'
      $dir_zabbix_server_confd  = '/etc/zabbix/zabbix_server.d'
      $proxy_package            = 'zabbix-proxy'
      $proxy_version            = 'present'
      $proxy_service            = 'zabbix-proxy'
      $proxy_status             = 'enabled'
      $web_package              = 'zabbix-web'
      $web_version              = 'present'
      $web_file_owner           = 'root'
      $web_file_group           = 'apache'
      $web_file_mode            = '0640'
      $web_dir_zabbix_php       = '/etc/zabbix/web'
    }
    /(Debian|ubuntu)/: {
      $agent_package            = 'zabbix-agent'
      $agent_version            = 'present'
      $agent_service            = 'zabbix-agent'
      $agent_status             = 'enabled'
      $file_zabbix_agentd_conf  = '/etc/zabbix/zabbix_agentd.conf'
      $dir_zabbix_agentd_confd  = '/etc/zabbix/zabbix_agentd.d'
      $server_package           = 'zabbix-server'
      $server_version           = 'present'
      $server_service           = 'zabbix-server'
      $server_status            = 'enabled'
      $alert_scripts_path       = '/usr/lib/zabbix/alertscripts'
      $external_scripts         = '/usr/lib/zabbix/externalscripts'
      $file_zabbix_server_conf  = '/etc/zabbix/zabbix_server.conf'
      $dir_zabbix_server_confd  = '/etc/zabbix/zabbix_server.d'
      $proxy_package            = 'zabbix-proxy'
      $proxy_version            = 'present'
      $proxy_service            = 'zabbix-proxy'
      $proxy_status             = 'enabled'
      $web_package              = 'zabbix-frontend-php'
      $web_version              = 'present'
      $web_file_owner           = 'root'
      $web_file_group           = 'www-data'
      $web_file_mode            = '0640'
      $web_dir_zabbix_php       = '/etc/zabbix/web'
    }
  }

}
