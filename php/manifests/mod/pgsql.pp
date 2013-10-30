# Class: php::mod::pgsql
class php::mod::pgsql (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pgsql':
    ensure => $package_ensure,
    name   => "php${major}-pgsql",
  }
}
