# Class: php::mod::pear
class php::mod::pear (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-pear":
    ensure  => $package_ensure,
  }
}
