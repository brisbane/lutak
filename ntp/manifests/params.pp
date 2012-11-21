# Class: ntp::params
#
#   The ntp configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ntp::params {
  $package_ensure = 'present'
  $client_servers = ['0.de.pool.ntp.org', '1.de.pool.ntp.org', '2.de.pool.ntp.org' ]
  $server_servers = ['0.de.pool.ntp.org', '1.de.pool.ntp.org', '2.de.pool.ntp.org' ]
  case $::osfamily {
    'RedHat': {
      $service_name             = 'ntpd'
      $client_package_name      = 'ntp'
      $server_package_name      = 'ntp'
      $needs_ntpdate            = true
      $ntpdate_path		= '/sbin/ntpdate'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat")
    }
  }
}
