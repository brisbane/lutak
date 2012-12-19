class php::modules::pecl::amqp (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php$major-pecl-amqp":
    ensure  => $package_ensure,
  }
}
