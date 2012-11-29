class php::modules::intl (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-intl":
    ensure  => $package_ensure,
  }
}
