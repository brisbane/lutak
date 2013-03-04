# Class: tsm
#
# This module manages tsm
#
class tsm (
  $package_ensure  = $tsm::params::package_ensure,
  $exclude         = $tsm::params::exclude,
  $backup_service  = $tsm::params::backup_service,
  $archive_service = $tsm::params::archive_service,
) inherits tsm::params {
  include yum::repo::srce::intern

  package { 'tsm-client':
    ensure  => $package_ensure,
  }
  service { [ 'dsmcad-backup', 'dsmcad-archive']:
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['tsm-client'],
  }


  if $backup_service == 'running' {
    service { [ 'dsmcad-backup']:
      ensure   => running,
      enable   => true,
      provider => redhat,
      require  => Package['tsm-client'],
    }
  }
  else {
    service { [ 'dsmcad-backup']:
      ensure   => 'stopped',
      enable   => false,
      provider => redhat,
      require  => Package['tsm-client'],
    }
  }

  if $archive_service == 'running' {
    service { [ 'dsmcad-archive']:
      ensure   => running,
      enable   => true,
      provider => redhat,
      require  => Package['tsm-client'],
    }
  }
  else {
    service { [ 'dsmcad-archive']:
      ensure   => 'stopped',
      enable   => false,
      provider => redhat,
      require  => Package['tsm-client'],
    }
  }

  # TODO:
  # expect -c "spawn /usr/bin/dsmc expect">:" send \"\r\" expect ":" send \"sunce.srce+tr00ba\r\" "
}
