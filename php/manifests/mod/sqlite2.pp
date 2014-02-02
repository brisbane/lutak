# Class: php::mod::sqlite2
class php::mod::sqlite2 (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-sqlite2':
    ensure => $package_ensure,
    name   => "php${major}-sqlite2",
  }
}
