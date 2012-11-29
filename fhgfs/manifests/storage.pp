# Class: fhgfs::client
#
# This module manages FhGFS client
#
class fhgfs::storage (
  $enable = false,
  $storage_directory = $fhgfs::storage_directory,
  $mgmtd_host = $fhgfs::mgmtd_host,
) inherits fhgfs {
  package { 'fhgfs-storage':
    ensure => present,
  }
  file { '/etc/fhgfs/fhgfs-storage.conf':
    require => Package['fhgfs-storage'],
    content => template('fhgfs/fhgfs-storage.conf.erb'),
  }
  service { 'fhgfs-storage':
    enable    => $enable,
    provider  => redhat,
    require   => Package['fhgfs-storage'],
#   subscribe => Subscribe['/etc/fhgfs/fhgfs-storage.conf'];
  }
}
