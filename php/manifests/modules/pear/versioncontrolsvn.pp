class php::modules::pear::versioncontrolsvn inherits php {
  package { "php$major-pear-VersionControl_SVN":
    ensure  => $package_ensure,
  }
}
