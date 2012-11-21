class php::modules::mysql inherits php {
  package { "php$major-mysql":
    ensure  => $package_ensure,
  }
}
