# Class: php::mod::pecl::memcache
class php::mod::pecl::memcache (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-pecl-memcache":
    ensure  => $package_ensure,
  }
}