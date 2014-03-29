# Class: php::mod::pdo
class php::mod::pdo (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pdo':
    ensure => $package_ensure,
    name   => "php${major}-pdo",
  }
}
