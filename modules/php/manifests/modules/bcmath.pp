class php::modules::bcmath inherits php {
  package { "php$major-bcmath":
    ensure  => $package_ensure,
  }
}
