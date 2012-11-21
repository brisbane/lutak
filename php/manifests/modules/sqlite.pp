class php::modules::sqlite inherits php {
  package { "php$major-sqlite":
    ensure  => $package_ensure,
  }
}
