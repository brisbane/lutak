# Class: mdadm
#
# This module manages md devices
#
class mdadm {
  package { 'mdadm':
    ensure => present,
  }
}
