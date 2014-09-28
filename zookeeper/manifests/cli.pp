#
# = Class: zookeeper::cli
#
class zookeeper::cli (
  $ensure           = $::zookeeper::params::ensure,
  $package          = $::zookeeper::params::cli_package,
  $version          = $::zookeeper::params::cli_version,
  $noops            = false,
) inherits zookeeper::params {

  ### Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent')
  validate_string($package)
  validate_string($version)

  ### Internal variables (that map class parameters)
  if $ensure == 'present' {
    $package_ensure = $version ? {
      ''      => 'present',
      default => $version,
    }
  } else {
    $package_ensure = 'absent'
  }

  ### Code
  package { 'zookeeper_cli':
    ensure => $package_ensure,
    name   => $package,
    noop   => $noops,
  }

}
