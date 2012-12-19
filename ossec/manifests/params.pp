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
  $ossec_server_ip  = '127.0.0.1'
  $ossec_client_id  = '1'
  $ossec_client_key = 'nokey_usehiera'
}
