# Class: php::mod::pecl::amqp
class php::mod::pecl::amqp (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-pecl-amqp":
    ensure  => $package_ensure,
  }
}
