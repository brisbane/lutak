# Class: ossec::params
#
#   The ossec configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ossec::params {
  $package_ensure   = 'present'
  $server_ip  = '127.0.0.1'
  $client_id  = '1'
  $client_key = 'nokey_usehiera'
  $client_ip = 'nokey_usehiera'
}
