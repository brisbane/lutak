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
  $ossec_server_ip  = $ossec::params::ossec_server_ip,
  $ossec_client_id  = $ossec::params::ossec_client_id,
  $ossec_client_key = $ossec::params::ossec_client_key,
  $package_ensure   = $ossec::params::package_ensure,
) inherits ossec::params {
  package { 'ossec-hids':
    ensure => $package_ensure,
  }
}
