class php::modules::xmlrpc (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-xmlrpc":
    ensure  => $package_ensure,
  }
}
