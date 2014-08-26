# Class: nagios::params
#
# This module contains defaults for nagios modules
#
class nagios::params {

  $ensure           = 'present'
  $version          = undef
  $status           = 'enabled'
  $file_mode        = '0600'
  $file_owner       = 'root'
  $file_group       = 'root'
  $autorestart      = true
  $dependency_class = 'nagios::dependency'
  $my_class         = undef

  # install package depending on major version
  case $::osfamily {
    default: {}
    /(RedHat|redhat|amazon)/: {
      $package           = 'nagios'
      $service           = 'nagios'
    }
    /(debian|ubuntu)/: {
    }
  }

}
