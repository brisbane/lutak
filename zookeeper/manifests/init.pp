#
# = Class: zookeeper
#
class zookeeper (
  $ensure              = $::zookeeper::params::ensure,
  $package             = $::zookeeper::params::package,
  $version             = $::zookeeper::params::version,
  $dependency_class    = $::zookeeper::params::dependency_class,
  $my_class            = $::zookeeper::params::my_class,
  $noops               = undef,
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

  ### Extra classes
  if $dependency_class { include $dependency_class }
  if $my_class         { include $my_class         }

  ### Code
  package { 'zookeeper':
    ensure => $package_ensure,
    name   => $package,
    noop   => $noops,
  }

}
