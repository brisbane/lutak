# Class: php::mod::pecl::imagick
class php::mod::pecl::imagick (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-pecl-imagick": ensure  => $package_ensure, }
}
