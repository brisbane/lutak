#
# = Class: haproxy::top
#
# This module installs HaTop
#
class haproxy::top (
  $package = 'hatop',
  $noops   = undef,
) {

  package { 'hatop':
    ensure => present,
    name   => $package,
    noop   => $noops,
  }

}
