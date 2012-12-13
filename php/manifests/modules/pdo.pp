class php::modules::pdo (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-pdo":
    ensure  => $package_ensure,
  }
}
