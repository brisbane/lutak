class php::modules::pecl::ssh2 inherits php {
  package { "php$major-pecl-ssh2":
    ensure  => $package_ensure,
  }
}
