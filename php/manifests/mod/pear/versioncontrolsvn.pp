# Class: php::mod::pear::versioncontrolsvn
class php::mod::pear::versioncontrolsvn (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { 'php-pear-VersionControl_SVN':
    ensure => $package_ensure,
    name   => "php${major}-pear-VersionControl_SVN",
  }
}
