# Class: php::mod::pecl::xdebug
class php::mod::pecl::xdebug (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pecl-xdebug':
    ensure => $package_ensure,
    name   => "php${major}-pecl-xdebug",
  }
  file {'/etc/php.d/xdebug_conf.ini':
    ensure  => present,
    source  => 'puppet:///modules/php/xdebug_conf.ini',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package["php${major}-pecl-xdebug"],
  }
}
