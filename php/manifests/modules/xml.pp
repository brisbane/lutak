class php::modules::xml (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-xml":
    ensure  => $package_ensure,
  }
}
