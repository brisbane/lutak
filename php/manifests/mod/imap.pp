# Class: php::mod::imap
class php::mod::imap (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-imap':
    ensure => $package_ensure,
    name   => "php${major}-imap",
  }
}
