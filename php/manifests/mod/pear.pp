# Class: php::mod::pear
class php::mod::pear (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pear':
    ensure => $package_ensure,
    name   => "php${major}-pear",
  }
}
