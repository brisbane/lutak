class php::modules::mcrypt inherits php {
  package { "php$major-mcrypt":
    ensure  => $package_ensure,
  }
}
