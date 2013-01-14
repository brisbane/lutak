# Class: fhgfs
#
# Base FhGFS class
#
class fhgfs (
  $mgmtd_host = 'localhost',
  $meta_directory = '/meta',
  $storage_directory = '/storage',
  $mgmtd_directory = '/mgmtd',
  $client_auto_remove_mins = 0,
  $meta_space_low_limit = '5G',
  $meta_space_emergency_limit = '3G',
  $storage_space_low_limit = '100G',
  $storage_space_emergency_limit = '10G',
  $version = '2011.04.r21-el6',
) {
  require yum::repo::fhgfs

  package { 'fhgfs-utils':
    ensure => $version,
  }
  file { '/etc/fhgfs/fhgfs-client.conf':
    require => Package['fhgfs-utils'],
    content => template('fhgfs/fhgfs-client.conf.erb'),
  }
}
