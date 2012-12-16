# Class: php::mod::bcmath
# Class: php::mod::bcmath
class php::mod::bcmath (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-bcmath":
    ensure  => $package_ensure,
  }
}
