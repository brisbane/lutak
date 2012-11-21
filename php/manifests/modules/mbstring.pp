class php::modules::mbstring inherits php {
  package { "php$major-mbstring":
    ensure  => $package_ensure,
  }
}
