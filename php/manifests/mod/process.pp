# Class: php::mod::process
class php::mod::process (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-process":
    ensure  => $package_ensure,
  }
}
