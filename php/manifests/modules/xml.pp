class php::modules::xml inherits php {
  package { "php$major-xml":
    ensure  => $package_ensure,
  }
}
