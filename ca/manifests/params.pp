#
# = Class: ca::params
#
class ca::params {

  if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
    $cert_addon_dir = '/etc/pki/ca-trust/source/anchors'
  } elsif $::osfamily == 'debian' {
    $cert_addon_dir = '/etc/ssl/ca'
  } else {
    fail("Class['ca::params']: Unsupported operatingsystem: ${::operatingsystem}")
  }

}
