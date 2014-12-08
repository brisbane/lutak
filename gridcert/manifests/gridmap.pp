# Class: gridcert::gridmap
#
# This module installs Globus grid-mapfile
#
class gridcert::gridmap (
  $location = 'puppet:///modules/gridcert/grid-mapfile',
) {
  include gridcert::package
  file { '/etc/grid-security/grid-mapfile':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => $location,
    require => Package['ca-policy-egi-core'],
  }
}
