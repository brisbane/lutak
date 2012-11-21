class php::modules::xmlrpc inherits php {
  package { "php$major-xmlrpc":
    ensure  => $package_ensure,
  }
}
