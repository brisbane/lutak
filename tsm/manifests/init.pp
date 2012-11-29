# Class: tsm
#
# This module manages tsm
#
class tsm (
  $package_ensure = $tsm::params::package_ensure,
  $exclude        = $tsm::params::exclude,
) inherits tsm::params {
  include yumreposd::srce_intern
  package { 'tsm-client':
    ensure  => $package_ensure,
    require => Class['yumreposd::srce_intern'],
  }
  service { [ 'dsmcad-backup', 'dsmcad-archive']:
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['tsm-client'],
  }
  # TODO:
  # expect -c "spawn /usr/bin/dsmc expect">:" send \"\r\" expect ":" send \"sunce.srce+tr00ba\r\" "

}
