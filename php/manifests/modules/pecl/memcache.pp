class php::modules::pecl::memcache inherits php {
  package { "php$major-pecl-memcache":
    ensure  => $package_ensure,
  }
}
