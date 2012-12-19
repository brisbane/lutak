class php::modules::bcmath (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-bcmath":
    ensure  => $package_ensure,
  }
}
