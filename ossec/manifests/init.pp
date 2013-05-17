# Class: ossec
#
# This module manages ossec and is standard for all hosts
#
# Requires:
#
#

# Sample Usage:
#   include ossec
#
class ossec (
  $server_ip        = $ossec::params::server_ip,
  $client_id        = $ossec::params::client_id,
  $client_key       = $ossec::params::client_key,
  $client_ip        = $ossec::params::client_ip,
  $client_name      = $ossec::params::client_name,
  $package_ensure   = $ossec::params::package_ensure,
) inherits ossec::params {
  package { 'ossec-hids':
    ensure => $package_ensure,
  }
}
