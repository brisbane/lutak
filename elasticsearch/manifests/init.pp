#
# = Class: elasticsearch
#
class elasticsearch (
  $ensure                  = $::elasticsearch::params::ensure,
  $package                 = $::elasticsearch::params::server_package,
  $version                 = $::elasticsearch::params::server_version,
  $service                 = $::elasticsearch::params::service,
  $service_ensure          = $::elasticsearch::params::service_ensure,
  $service_enable          = $::elasticsearch::params::service_enable,
  $service_restart         = true,
  $elasticsearch_user      = $::elasticsearch::params::elasticsearch_user,
  $elasticsearch_group     = $::elasticsearch::params::elasticsearch_group,
  $file_mode               = $::elasticsearch::params::file_mode,
  $file_owner              = $::elasticsearch::params::file_owner,
  $file_group              = $::elasticsearch::params::file_group,
  $confdir                 = $::elasticsearch::params::confdir,
  $datadir                 = $::elasticsearch::params::datadir,
  $logdir                  = $::elasticsearch::params::logdir,
  $plugintool              = $::elasticsearch::params::plugintool,
  $plugindir               = $::elasticsearch::params::plugindir,
  $template_config         = 'elasticsearch/elasticsearch.yml.erb',
  $file_config             = $::elasticsearch::params::file_config,
  $template_sysconfig      = 'elasticsearch/sysconfig.yml.erb',
  $path_sysconfig          = $::elasticsearch::params::path_sysconfig,
  $es_heap_size            = '4g',
  $es_heap_newsize         = undef,
  $es_direct_size          = undef,
  $es_java_opts            = undef,
  $max_open_files          = '65535',
  $max_locked_memory       = undef,
  $max_map_count           = '262144',
  $nodename                = $::hostname,
  $nodemaster              = undef,
  $nodedata                = undef,
  $clustername             = undef,
  $number_of_replicas      = undef,
  $number_of_shards        = undef,
  $bind_host               = undef,
  $host                    = undef,
  $port                    = undef,
  $tcp_compress            = undef,
  $http_enabled            = undef,
  $http_port               = undef,
  $http_max_content_length = undef,
  $dependency_class        = $::elasticsearch::params::dependency_class,
  $my_class                = $::elasticsearch::params::my_class,
  $noops                   = undef,
) inherits elasticsearch::params {

  ### Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent')
  validate_string($package)
  validate_string($version)
  validate_string($service)
  validate_re($service_ensure, ['running','stopped','undef'], 'Valid values are: running, stopped')
  validate_re($service_enable, ['true','false','undef'], 'Valid values are: true, false')

  ### Internal variables (that map class parameters)
  if $ensure == 'present' {
    $package_ensure = $version ? {
      ''      => 'present',
      default => $version,
    }
    $file_ensure = present
  } else {
    $package_ensure = 'absent'
    $file_ensure    = absent
  }

  ### Defaults
  File {
    ensure  => $file_ensure,
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
    require => Package['elasticsearch'],
    notify  => Service['elasticsearch'],
    noop    => $noops,
  }

  ### Extra classes
  if $dependency_class { include $dependency_class }
  if $my_class         { include $my_class         }

  ### Code

  # package
  package { 'elasticsearch':
    ensure => $package_ensure,
    name   => $package,
    noop   => $noops,
  }

  file { '/var/lib/elasticsearch':
    ensure => directory,
    path   => $datadir,
    owner  => $elasticsearch_user,
    group  => $elasticsearch_group,
    mode   => '0770',
  }

  file { '/var/log/elasticsearch':
    ensure => directory,
    path   => $logdir,
    owner  => $elasticsearch_user,
    group  => $elasticsearch_group,
  }

  file { '/etc/elasticsearch':
    ensure => directory,
    path   => $confdir,
  }

  file { '/usr/share/elasticsearch/plugins':
    ensure => directory,
    path   => $plugindir,
  }

  file { 'elasticsearch.yml':
    path    => "${confdir}/${file_config}",
    content => template($template_config),
  }

  file { '/etc/sysconfig/elasticsearch':
    path    => $path_sysconfig,
    content => template($template_sysconfig),
  }

  # service
  service { 'elasticsearch':
    ensure  => $service_ensure,
    enable  => $service_enable,
    name    => $service,
    require => Package['elasticsearch'],
    noop    => $noops,
  }


}
