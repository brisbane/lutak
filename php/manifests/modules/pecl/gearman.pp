class php::modules::pecl::gearman inherits php {
  package { "php$major-pecl-gearman":
    ensure  => $package_ensure,
  }
}
