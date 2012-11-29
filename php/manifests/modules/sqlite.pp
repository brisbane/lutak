class php::modules::sqlite (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-sqlite":
    ensure  => $package_ensure,
  }
}
