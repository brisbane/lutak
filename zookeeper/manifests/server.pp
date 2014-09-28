#
# = Class: zookeeper::server
#
class zookeeper::server (
  $ensure              = $::zookeeper::params::ensure,
  $package             = $::zookeeper::params::server_package,
  $version             = $::zookeeper::params::server_version,
  $service             = $::zookeeper::params::service,
  $service_ensure      = $::zookeeper::params::service_ensure,
  $service_enable      = $::zookeeper::params::service_enable,
  $file_mode           = $::zookeeper::params::file_mode,
  $file_owner          = $::zookeeper::params::file_owner,
  $file_group          = $::zookeeper::params::file_group,
  $myid                = undef,
  $confdir             = $::zookeeper::params::confdir,
  $confdir_altname     = $::zookeeper::params::confdir_altname,
  $confdir_altlink     = $::zookeeper::params::confdir_altlink,
  $datadir             = $::zookeeper::params::datadir,
  $datalogdir          = $::zookeeper::params::datalogdir,
  $manage_alternatives = $::zookeeper::params::manage_alternatives,
  $template_zoocfg     = 'zookeeper/zoo.cfg.erb',
  $source_environment  = 'puppet:///modules/zookeeper/environment',
  $source_log4j        = 'puppet:///modules/zookeeper/log4j.properties',
  $source_configxsl    = 'puppet:///modules/zookeeper/configuration.xsl',
  $template_myid       = 'zookeeper/myid.erb',
  $nodes               = [],
  $myid                = undef,
  $noops               = undef,
) inherits zookeeper::params {

  include ::zookeeper

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
    require => Package['zookeeper-server'],
    notify  => Service['zookeeper'],
    noop    => $noops,
  }

  ### Code
  package { 'zookeeper-server':
    ensure => $package_ensure,
    name   => $package,
    noop   => $noops,
  }

  file { 'zookeeper_conf_dir' :
    ensure  => directory,
    path    => $confdir,
    require => Package['zookeeper-server'],
  }

  # if we manage alternatives, then set up symlink
  if ( $manage_alternatives ) {
    alternative_entry { $confdir :
      altname  => $confdir_altname,
      altlink  => $confdir_altlink,
      priority => '15',
      require  => File['zookeeper_conf_dir'],
    }

    alternatives { $confdir_altname :
      path    => $confdir,
      require => Alternative_entry[$confdir],
    }
  }

  # configuration files
  file { '/etc/zookeeper/zoo.cfg':
    path    => "${confdir}/zoo.cfg",
    content => template($template_zoocfg),
  }

  file { '/etc/zookeeper/environment':
    path   => "${confdir}/environment",
    source => $source_environment,
  }

  file { '/etc/zookeeper/log4j.properties':
    path   => "${confdir}/log4j.properties",
    source => $source_log4j,
  }

  file { '/etc/zookeeper/configuration.xsl':
    path   => "${confdir}/configuration.xsl",
    source => $source_configxsl,
  }

  # myid
  file { '/etc/zookeeper/myid':
    path    => "${confdir}/myid",
    content => template($template_myid),
  }
  file { '/var/lib/zookeeper/myid':
    ensure  => symlink,
    path    => "${datadir}/myid",
    target  => "${confdir}/myid",
  }

  # service
  service { 'zookeeper':
    ensure  => $service_ensure,
    enable  => $service_enable,
    name    => $service,
    require => [
      Package['zookeeper-server'],
      File['/etc/zookeeper/zoo.cfg'],
    ],
    noop    => $noops,
  }

}
