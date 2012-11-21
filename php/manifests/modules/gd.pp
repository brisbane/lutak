class php::modules::gd inherits php {
  package { "php$major-gd":
    ensure  => $package_ensure,
  }
}
