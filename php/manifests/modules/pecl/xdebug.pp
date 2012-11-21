class php::modules::pecl::xdebug inherits php {
  package { "php$major-pecl-xdebug":
    ensure => $package_ensure,
  }
  file {'/etc/php.d/xdebug_conf.ini':
    ensure  => present,
    source  => 'puppet:///modules/php/xdebug_conf.ini',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package["php$major-pecl-xdebug"],
  }
}
