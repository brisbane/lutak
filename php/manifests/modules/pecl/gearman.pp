class php::modules::pecl::gearman (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-pecl-gearman":
    ensure  => $package_ensure,
  }
}
