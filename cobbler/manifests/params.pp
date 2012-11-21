# Class: cobbler::params
#
#   The cobbler configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class cobbler::params {
  case $::osfamily {
    'RedHat': {
      $service_name = 'cobblerd'
      $package_name = 'cobbler'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat")
    }
  }
  $package_ensure = 'present'

  # general settings
  $next_server_ip = "${::ipaddress}"
  $server_ip      = "${::ipaddress}"
  $distro_path    = '/distro'
  $nameservers    = '127.0.0.1'

  # default root password for kickstart files
  $defaultrootpw = 'bettergenerateityourself'

  # dhcp options
  $manage_dhcp        = 0
  $dhcp_option        = 'isc'
  $dhcp_interfaces    = 'eth0'
  $dhcp_dynamic_range = 0

  # dns options
  $manage_dns = 0
  $dns_option = 'dnsmasq'

  # tftpd options
  $manage_tftpd = 1
  $tftpd_option = 'in_tftpd'

  # puppet integration setup
  $puppet_auto_setup                     = 1
  $sign_puppet_certs_automatically       = 1
  $remove_old_puppet_certs_automatically = 1
}
