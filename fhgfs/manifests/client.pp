# Class: fhgfs::client
#
# This module manages FhGFS client
#
class fhgfs::client {
  package { 'kernel-devel' :
    ensure   => present,
  }
  package { 'fhgfs-helperd':
    ensure   => present,
  }
  package { 'fhgfs-client':
    ensure   => present,
    require  => Package['kernel-devel'],
  }
  service { 'fhgfs-helperd':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['fhgfs-helperd'],
  }
  file { '/etc/fhgfs/fhgfs-client-home.conf':
    require => Package['fhgfs-client'],
    source  => 'puppet:///files/fhgfs/fhgfs-client-home.conf',
  }
  file { '/etc/fhgfs/fhgfs-client-shared.conf':
    require => Package['fhgfs-client'],
    source  => 'puppet:///files/fhgfs/fhgfs-client-shared.conf',
  }
  file { '/etc/fhgfs/fhgfs-mounts.conf':
    require => Package['fhgfs-client'],
    source  => 'puppet:///files/fhgfs/fhgfs-mounts.conf',
  }
  service { 'fhgfs-client':
    enable   => true,
    provider => redhat,
    require  => [ Package['fhgfs-client'], Service['fhgfs-helperd'], File['/etc/fhgfs/fhgfs-client-home.conf'], File['/etc/fhgfs/fhgfs-client-shared.conf'], File['/etc/fhgfs/fhgfs-mounts.conf'] ],
  }
}
