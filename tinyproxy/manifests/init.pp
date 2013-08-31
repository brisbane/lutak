# Class: tinyproxy
#
# This modules installs tinyproxy
#
class tinyproxy {
  package { 'tinyproxy':
    ensure  => present,
  }
  service { 'tinyproxy':
    ensure   => running,
    enable   => true,
    provider => 'redhat',
    require  => Package['tinyproxy'],
  }
}
