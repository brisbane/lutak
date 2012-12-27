# Class: puppet
#
# This module manages puppet and is standard for all hosts
#
# Requires:
#

# Sample Usage:
#   include puppet
#
define puppet::environment ( ) {
  $environment = $title
  File {
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }
  # create directories
  file { "/etc/puppet/environments/${environment}": }
  file { "/etc/puppet/environments/${environment}/modules": }
}
