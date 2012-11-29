class php::modules::pear (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-pear":
    ensure  => $package_ensure,
  }
}
