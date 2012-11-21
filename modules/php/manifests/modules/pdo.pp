class php::modules::pdo inherits php {
  package { "php$major-pdo":
    ensure  => $package_ensure,
  }
}
