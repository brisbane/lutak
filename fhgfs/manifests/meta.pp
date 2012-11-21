# Class: fhgfs::client
#
# This module manages FhGFS client
#
class fhgfs::meta (
  $enable = false,
  $meta_directory = $fhgfs::meta_directory,
  $mgmtd_host = $fhgfs::mgmtd_host,
) inherits fhgfs {
  package { 'fhgfs-meta':
    ensure => present,
  }
  file { '/etc/fhgfs/fhgfs-meta.conf':
    require => Package['fhgfs-meta'],
    content  => template('fhgfs/fhgfs-meta.conf.erb'),
  }
  service { 'fhgfs-meta':
    enable    => $enable,
    provider  => redhat,
    require   => Package['fhgfs-meta'],
#    subscribe => Subscribe['/etc/fhgfs/fhgfs-meta.conf'];
  }
}
