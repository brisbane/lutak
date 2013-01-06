# Class: gridcert
#
# This module installs host grid certificate
# and key
#
class gridcert {
  include gridcert::package
  file { '/etc/grid-security/hostcert.pem':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0444',
    source  => [
      'puppet:///private/gridcert/hostcert.pem',
    ],
    require => Package['lcg-CA'],
  }
  file { '/etc/grid-security/hostkey.pem':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0400',
    source  => [
      'puppet:///private/gridcert/hostkey.pem',
    ],
    require => Package['lcg-CA'],
  }
}
