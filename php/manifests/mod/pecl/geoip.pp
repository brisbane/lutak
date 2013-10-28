# Class: php::mod::pecl::geoip
class php::mod::pecl::geoip (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pecl-geoip':
    ensure => $package_ensure,
    name   => "php${major}-pecl-geoip",
  }
}
