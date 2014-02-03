# Class: vmtools::xen
#
# Installs the Xen Tools for XenServer from
# Srce Intern repo
class vmtools::xen {
  case $::osfamily {
    /(RedHat|redhat)/: {
      include ::yum::repo::srce::intern
      package { [ 'xe-guest-utilities', 'xe-guest-utilities-xenstore' ]: ensure => present, }
    }
    /(Debian|debian|Ubuntu|ubuntu)/: {
      include ::aptrepo::debian
      include ::aptrepo::srce
      package { [ 'xe-guest-utilities' ]: ensure => present, }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat and Debian")
    }
  }
}
