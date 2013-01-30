# Class: php::mod::pecl::memcache
class php::mod::pecl::memcache (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pecl-memcache':
    ensure => $package_ensure,
    name   => "php${major}-pecl-memcache",
  }
}
