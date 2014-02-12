# Class: php::mod::pecl::ssh2
class php::mod::pecl::ssh2 (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  case $::operatingsystemrelease {
    default: {
      package { 'php-pecl-ssh2':
        ensure => $package_ensure,
        name   => "php${major}-pecl-ssh2",
      }
    }
    /^5.*/: {
    }
  }
}
