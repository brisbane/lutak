# Class: zabbix20::params
#
# This module contains defaults for zabbix modules
#
class zabbix20::params {
  $package_ensure            = 'present'
  $major                     = ''
  $server_name               = 'mon'
  $server_active             = 'mon'
  $client_name               = $::fqdn
  $db                        = 'pgsql'
  $dbhost                    = 'localhost'
  $dbname                    = 'zabbix'
  $dbuser                    = 'zabbix'
  $dbpass                    = 'secret'
  $dbsocket                  = false
  $dbsocket_path             = '/var/lib/mysql/mysql.sock'
  $purge_conf_dir            = false
}
