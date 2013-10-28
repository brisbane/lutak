# Class: php::mod::xmlrpc
class php::mod::xmlrpc (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-xmlrpc':
    ensure => $package_ensure,
    name   => "php${major}-xmlrpc",
  }
}
