# Class: tsm
#
# This module manages tsm
#
class tsm (
  $ensure            = $::tsm::params::ensure,
  $package           = $::tsm::params::package,
  $version           = $::tsm::params::version,
  $backup_server     = $::tsm::params::backup_server,
  $backup_service    = $::tsm::params::backup_service,
  $backup_status     = $::tsm::params::backup_status,
  $backup_exclude    = [],
  $file_backup_excl  = $::tsm::params::file_backup_excl,
  $backup_password   = 'UNSET',
  $archive_server    = $::tsm::params::archive_server,
  $archive_service   = $::tsm::params::archive_service,
  $archive_status    = $::tsm::params::archive_status,
  $archive_password  = 'UNSET',
  $archive_exclude   = [],
  $file_archive_excl = $::tsm::params::file_archive_excl,
  $nodename          = $::tsm::params::nodename,
  $file_mode         = $::tsm::params::file_mode,
  $file_owner        = $::tsm::params::file_owner,
  $file_group        = $::tsm::params::file_group,
  $file_dsm_sys      = $::tsm::params::file_dsm_sys,
  $autorestart       = $::tsm::params::autorestart,
  $dependency_class  = $::tsm::params::dependency_class,
  $my_class          = $::tsm::params::my_class,
) inherits tsm::params {

  ### Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent')
  validate_string($package)
  validate_string($version)
  validate_string($backup_server)
  validate_string($backup_service)
  validate_re($backup_status,  ['enabled','disabled','running','stopped','activated','deactivated','unmanaged'], 'Valid values are: enabled, disabled, running, stopped, activated, deactivated and unmanaged')
  validate_string($archive_server)
  validate_string($archive_service)
  validate_re($archive_status, ['enabled','disabled','running','stopped','activated','deactivated','unmanaged'], 'Valid values are: enabled, disabled, running, stopped, activated, deactivated and unmanaged')
  validate_string($nodename)
  validate_bool($autorestart)

  ### Internal variables (that map class parameters)
  if $ensure == 'present' {
    $package_ensure = $version ? {
      ''      => 'present',
      default => $version,
    }
    $backup_service_enable = $backup_status ? {
      'enabled'     => true,
      'disabled'    => false,
      'running'     => undef,
      'stopped'     => undef,
      'activated'   => true,
      'deactivated' => false,
      'unmanaged'   => undef,
    }
    $backup_service_ensure = $backup_status ? {
      'enabled'     => 'running',
      'disabled'    => 'stopped',
      'running'     => 'running',
      'stopped'     => 'stopped',
      'activated'   => undef,
      'deactivated' => undef,
      'unmanaged'   => undef,
    }
    $archive_service_enable = $archive_status ? {
      'enabled'     => true,
      'disabled'    => false,
      'running'     => undef,
      'stopped'     => undef,
      'activated'   => true,
      'deactivated' => false,
      'unmanaged'   => undef,
    }
    $archive_ervice_ensure = $archive_status ? {
      'enabled'     => 'running',
      'disabled'    => 'stopped',
      'running'     => 'running',
      'stopped'     => 'stopped',
      'activated'   => undef,
      'deactivated' => undef,
      'unmanaged'   => undef,
    }

    $file_ensure = present
  } else {
    $package_ensure = 'absent'
    $backup_service_enable = undef
    $backup_service_ensure = stopped
    $archive_service_enable = undef
    $archive_service_ensure = stopped
    $file_ensure    = absent
  }

  $file_notify = $autorestart ? {
    true  => Service['stdmod'],
    false => undef,
  }

  ### Extra classes
  if $dependency_class { include $dependency_class }
  if $my_class         { include $my_class         }


  package { 'tsm-client':
    ensure => $package_ensure,
    name   => $package,
  }

  service { 'dsmcad-backup':
    ensure  => $backup_service_ensure,
    enable  => $backup_service_enable,
    require => Package['tsm-client'],
  }

  service { 'dsmcad-archive':
    ensure   => $archive_service_ensure,
    enable   => $archive_service_enable,
    require  => Package['tsm-client'],
  }

  # set defaults for file resource in this scope.
  File {
    ensure  => $file_ensure,
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
  }

  file { $file_dsm_sys :
    content => template('tsm/dsm.sys.erb'),
  }

  file { $file_backup_excl :
    content => template('tsm/dsm-inclexcl.backup.erb'),
  }

  file { $file_archive_excl :
    content => template('tsm/dsm-inclexcl.archive.erb'),
  }


}
# vi:syntax=puppet:filetype=puppet:ts=4:et:nowrap:
