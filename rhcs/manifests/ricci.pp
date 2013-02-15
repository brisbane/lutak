# Class: rhcs::ricci
#
# This module configures ricci (cluster & storage
# configuration daemon)
#
class rhcs::ricci (
  $cluster_name = $rhcs::cluster_name,
) inherits rhcs {
  # defaults
  File {
    ensure  => file,
    owner   => ricci,
    group   => ricci,
    mode    => '0640',
    require => Package['ricci'],
  }

  # package
  package { 'ricci': ensure => present, }

  # CA files
  file { '/var/lib/ricci/certs/cacert.pem':
    source  => 'puppet:///private/ricci/ca/cacert.pem',
    mode    => '0644',
  }
  file { '/var/lib/ricci/certs/server.p12':
    source => 'puppet:///private/ricci/ca/server.p12',
    mode   => '0644',
  }
  file { '/var/lib/ricci/certs/cacert.config':
    source => 'puppet:///private/ricci/ca/cacert.config',
    mode   => '0644',
  }
  file { '/var/lib/ricci/certs/cert8.db':    source => 'puppet:///private/ricci/ca/cert8.db', }
  file { '/var/lib/ricci/certs/key3.db':     source => 'puppet:///private/ricci/ca/key3.db', }
  file { '/var/lib/ricci/certs/privkey.pem': source => 'puppet:///private/ricci/ca/privkey.pem', }
  file { '/var/lib/ricci/certs/secmod.db':   source => 'puppet:///private/ricci/ca/secmod.db', }

  # service
  service { 'ricci':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => [
      File['/var/lib/ricci/certs/cacert.pem'],
      File['/var/lib/ricci/certs/server.p12'],
      File['/var/lib/ricci/certs/cert8.db'],
      File['/var/lib/ricci/certs/key3.db'],
      File['/var/lib/ricci/certs/privkey.pem'],
      File['/var/lib/ricci/certs/secmod.db'], ],
  }

  # export cacert, because ccs_sync uses it as client cert
  @@file { "/var/lib/ricci/certs/clients/client_cert_${::hostname}":
    source  => "puppet:///files/rhcs/${cluster_name}/client_cert_${::hostname}",
    tag     => "ricci_client_${cluster_name}",
  }

  # collect client certificates for this cluster
  File <<| tag == "ricci_client_${cluster_name}" |>>
}
