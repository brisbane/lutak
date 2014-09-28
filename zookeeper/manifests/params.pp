#
# Class: zookeeper::params
#
# This module contains defaults for other ZooKeeper modules
#
class zookeeper::params {

  # global settings
  $ensure     = 'present'

  # global file properites
  $file_owner = 'root'
  $file_group = 'root'
  $file_mode  = '0644'

  # global module dependencies
  $dependency_class = undef
  $my_class         = undef

  # module specific settings (server)
  $service_ensure = 'running'
  $service_enable = 'true'

  # install package depending on major version
  case $::osfamily {
    default: {
    }
    /(RedHat|redhat|amazon)/: {
      # zookeeper
      $package              = 'zookeeper'
      $version              = 'present'
      $confdir              = '/etc/zookeeper/conf_active'
      $confdir_altname      = 'zookeeper-conf'
      $confdir_altlink      = '/etc/zookeeper/conf'
      $datadir              = '/var/lib/zookeeper'
      $datalogdir           = '/var/lib/zookeeper/log'
      $manage_alternatives  = true
      # server package
      $server_package       = 'zookeeper-server'
      $server_version       = 'present'
      $server_service       = 'zookeeper'
      # cli package
      $cli_package          = 'zookeeper-java'
      $cli_version          = 'present'
    }
    /(Debian|debian|Ubuntu|ubuntu)/: {
      # zookeeper
      $package              = 'zookeeper'
      $version              = 'present'
      $confdir              = '/etc/zookeeper/conf_active'
      $confdir_altname      = 'zookeeper-conf'
      $confdir_altlink      = '/etc/zookeeper/conf'
      $datadir              = '/var/lib/zookeeper'
      $datalogdir           = '/var/log/zookeeper'
      $manage_alternatives  = true
      # server package
      $server_package       = 'zookeeperd'
      $server_version       = 'present'
      $server_service       = 'zookeeper'
      # cli package
      $cli_package          = 'zookeeper-bin'
      $cli_version          = 'present'
    }
  }
}
