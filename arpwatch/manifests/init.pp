# Class: arpwatch
#
# This modules installs arpwatch
#
class arpwatch {
  package { 'arpwatch':
    ensure  => installed,
  }
  service { 'arpwatch':
    ensure   => running,
    enable   => true,
    provider => 'redhat',
    require  => Package['arpwatch'],
  }
}
