class php::modules::intl inherits php {
  package { "php$major-intl":
    ensure  => $package_ensure,
  }
}
