# Class: php$major
#
# This module manages php$major installation for CentOS 5
#
class php (
  $major          = $php::params::major,
  $package_ensure = $php::params::package_ensure,
  $timezone       = $::timezone,
) inherits php::params {
  # packages from CentOS base
  package { 'php':
    ensure => $package_ensure,
    name   => "php${major}",
  }
  package { 'php-cli':
    ensure => $package_ensure,
    name   => "php${major}-cli",
  }
  package { 'php-common':
    ensure => $package_ensure,
    name   => "php${major}-common",
  }

  file { '/etc/php.d/timezone.ini':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('php/timezone.ini.erb'),
    require => Package['php-common'],
  }
}
