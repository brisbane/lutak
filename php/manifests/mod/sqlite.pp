# Class: php::mod::sqlite
class php::mod::sqlite (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-sqlite":
    ensure  => $package_ensure,
  }
}
