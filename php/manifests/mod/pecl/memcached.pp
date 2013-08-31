# Class: php::mod::pecl::memcached
class php::mod::pecl::memcached (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pecl-memcached':
    ensure => $package_ensure,
    name   => "php${major}-pecl-memcached",
  }
}
