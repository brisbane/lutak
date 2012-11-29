class php::modules::process (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-process":
    ensure  => $package_ensure,
  }
}
