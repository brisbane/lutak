# Class: php::mod::mbstring
class php::mod::mbstring (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-mbstring":
    ensure  => $package_ensure,
  }
}
