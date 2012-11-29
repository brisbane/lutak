class php::modules::mysql (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-mysql":
    ensure  => $package_ensure,
  }
}
