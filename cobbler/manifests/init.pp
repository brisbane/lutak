# Class: cobbler
#
# This module manages Cobbler
# https://fedorahosted.org/cobbler/
#
# Requires:
#   $cobbler_listen_ip be set in the nodes manifest, else defaults to $ipaddress_eth1
#
class cobbler (
  $service_name       = $cobbler::params::service_name,
  $package_name       = $cobbler::params::package_name,
  $package_ensure     = $cobbler::params::package_ensure,
  $distro_path        = $cobbler::params::distro_path,
  $manage_dhcp        = $cobbler::params::manage_dhcp,
  $dhcp_dynamic_range = $cobbler::params::dhcp_dynamic_range,
  $manage_dns         = $cobbler::params::manage_dns,
  $dns_option         = $cobbler::params::dns_option,
  $manage_tftpd       = $cobbler::params::manage_tftpd,
  $tftpd_option       = $cobbler::params::tftpd_option,
  $server_ip          = $cobbler::params::server_ip,
  $next_server_ip     = $cobbler::params::next_server_ip,
  $nameservers        = $cobbler::params::nameservers,
  $dhcp_interfaces    = $cobbler::params::dhcp_interfaces,
  $defaultrootpw      = $cobbler::params::defaultrootpw,
  $apache_service     = $cobbler::params::apache_service,
) inherits cobbler::params {

  # use apache modules
  include apache::mod::wsgi
  class { 'apache::mod::proxy': proxy_allow => "$server_ip $::ipaddress 127.0.0.1", }
  class { 'apache::mod::proxy_http': }

  package { 'tftp-server':
    ensure => present,
  }
  package { 'syslinux':
    ensure => present,
  }
  package { $package_name :
    ensure  => $package_ensure,
    require => [ Package['syslinux'], Package['tftp-server'], ], 
  }
  service { $service_name :
    ensure  => running,
    enable  => true,
    require => Package[$package_name],
  }
  file { $distro_path :
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }
  file { "$distro_path/kickstarts" :
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }
  file { '/etc/cobbler/settings':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('cobbler/settings.erb'),
    require => Package["$package_name"],
    notify  => Service["$service_name"],
  }
  file { '/etc/cobbler/modules.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('cobbler/modules.conf.erb'),
    require => Package["$package_name"],
    notify  => Service["$service_name"],
  }
  file { '/etc/httpd/conf.d/distros.conf':
    ensure  => present, 
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('cobbler/distros.conf.erb'),
  }
  file { '/etc/httpd/conf.d/cobbler.conf':
    ensure  => present, 
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('cobbler/cobbler.conf.erb'),
  }
  exec { 'cobblersync':
    command     => '/usr/bin/cobbler sync',
    refreshonly => true,
  }
  # include ISC DHCP only if we choose manage_dhcp
  if $manage_dhcp == '1' {
    package { 'dhcp':
      ensure => present,
    }
    service { 'dhcpd':
      ensure  => running,
      require => Package['dhcp'],
    }
    file { '/etc/cobbler/dhcp.template':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('cobbler/dhcp.template.erb'),
      require => Package["$package_name"],
      notify  => Exec['cobblersync'],
    }
  }
}
