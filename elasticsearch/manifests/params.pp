#
# = Class: elasticsearch::params
#
# This module contains defaults for other ZooKeeper modules
#
class elasticsearch::params {

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
      $package              = 'elasticsearch'
      $version              = 'present'
      $confdir              = '/etc/elasticsearch'
      $logdir               = '/var/log/elasticsearch'
      $datadir              = '/var/lib/elasticsearch'
      $elasticsearch_user   = 'elasticsearch'
      $elasticsearch_group  = 'elasticsearch'
      $plugindir            = '/usr/share/elasticsearch/plugins'
      $plugintool           = '/usr/share/elasticsearch/bin/plugin'
      $template_config      = 'elasticsearch/elasticsearch.yml.erb'
      $file_config          = 'elasticsearch.yml'
      $template_sysconfig   = 'elasticsearch/sysconfig.yml.erb'
      $path_sysconfig       = '/etc/sysconfig/elasticsearch'
    }
    /(Debian|debian|Ubuntu|ubuntu)/: {
      $package              = 'elasticsearch'
      $version              = 'present'
      $confdir              = '/etc/elasticsearch'
      $logdir               = '/var/log/elasticsearch'
      $datadir              = '/var/lib/elasticsearch'
      $elasticsearch_user   = 'elasticsearch'
      $elasticsearch_group  = 'elasticsearch'
      $plugindir            = '/usr/share/elasticsearch/plugins'
      $plugintool           = '/usr/share/elasticsearch/bin/plugin'
      $template_config      = 'elasticsearch/elasticsearch.yml.erb'
      $file_config          = 'elasticsearch.yml'
      $template_sysconfig   = 'elasticsearch/sysconfig.yml.erb'
      $path_sysconfig       = '/etc/default/elasticsearch'
    }
  }
}
