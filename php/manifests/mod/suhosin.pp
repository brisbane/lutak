# Class: php::mod::suhosin
class php::mod::suhosin (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-suhosin':
    ensure => $package_ensure,
    name   => "php${major}-suhosin",
  }
}
