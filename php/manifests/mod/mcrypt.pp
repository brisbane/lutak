# Class: php::mod::mcrypt
class php::mod::mcrypt (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-mcrypt":
    ensure  => $package_ensure,
  }
}
