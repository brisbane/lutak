# Class: ssh
#
# This module manages ssh
#
class ssh (
  $server_package_name = $ssh::params::server_package_name,
  $package_ensure      = $ssh::params::package_ensure,
  $service_name        = $ssh::params::service_name,
) inherits ssh::params {

  package { 'openssh-clients': ensure => present, }

}
