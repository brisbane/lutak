class php::modules::soap inherits php {
  package { "php$major-soap":
    ensure  => $package_ensure,
  }
}
