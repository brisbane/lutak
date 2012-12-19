class php::modules::pecl::ssh2 (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-pecl-ssh2":
    ensure  => $package_ensure,
  }
}
