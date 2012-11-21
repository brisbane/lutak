class php::modules::pecl::amqp inherits php {
  package { "php$major-pecl-amqp":
    ensure  => $package_ensure,
  }
}
