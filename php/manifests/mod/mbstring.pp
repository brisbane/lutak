# Class: php::mod::mbstring
class php::mod::mbstring (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-mbstring':
    ensure => $package_ensure,
    name   => "php${major}-mbstring",
  }
}
