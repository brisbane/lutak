# Class: php::mod::pear::versioncontrolsvn
class php::mod::pear::versioncontrolsvn (
  $major          = $php::major,
  $package_ensure = $php::package_ensure,
) inherits php {
  package { "php${major}-pear-VersionControl_SVN":
    ensure  => $package_ensure,
  }
}
