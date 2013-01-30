# Class: php::mod::pear::phing
class php::mod::pear::phing (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pear-phing':
    ensure => $package_ensure,
    name   => "php${major}-pear-phing",
  }
}
