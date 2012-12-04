# Class: php$major
#
# This module manages php$major installation for CentOS 5
#
class php (
  $major          = $php::params::major,
  $package_ensure = $php::params::package_ensure,
) inherits php::params {
  # packages from CentOS base
  package { "php$major":
    ensure  => $package_ensure,
  }
  package { "php$major-cli":
    ensure  => $package_ensure,
  }
  package { "php$major-common":
    ensure  => $package_ensure,
  }
}
