class php::modules::mbstring (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-mbstring":
    ensure  => $package_ensure,
  }
}
