# Class: php::mod::xml
class php::mod::xml (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-xml':
    ensure => $package_ensure,
    name   => "php${major}-xml",
  }
}
