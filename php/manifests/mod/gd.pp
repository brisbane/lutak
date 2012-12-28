# Class: php::mod::gd
class php::mod::gd (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-gd":
    ensure  => $package_ensure,
  }
}