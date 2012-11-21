class php::modules::process inherits php {
  package { "php$major-process":
    ensure  => $package_ensure,
  }
}
