# Class: php::mod::ldap
class php::mod::ldap (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-ldap':
    ensure => $package_ensure,
    name   => "php${major}-ldap",
  }
}
