class php::modules::pear inherits php {
  package { "php$major-pear":
    ensure  => $package_ensure,
  }
}
