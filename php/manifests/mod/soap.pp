# Class: php::mod::soap
class php::mod::soap (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-soap":
    ensure  => $package_ensure,
  }
}
