# Class: gridcert
#
# This module installs host grid certificate
# and key
#
class gridcert {
  package { 'lcg-CA':
    ensure  => latest,
  }
  file { '/etc/grid-security/hostcert.pem':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => [
      'puppet:///private/gridcert/hostcert.pem',
    ],
    require => Package['lcg-CA'],
  }
  file { '/etc/grid-security/hostkey.pem':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    source  => [
      'puppet:///private/gridcert/hostkey.pem',
    ],
    require => Package['lcg-CA'],
  }
}
