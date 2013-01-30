# Class: php::mod::mysql
class php::mod::mysql (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-mysql':
    ensure => $package_ensure,
    name   => "php${major}-mysql",
  }
}
