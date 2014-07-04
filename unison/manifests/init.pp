#
# = Class: unison
#
# This module manages Unison
#
#
# == Parameters
#
# [*ensure*]
#   Type: string, default: 'present'
#   Manages package installation and class resources. Possible values:
#   * 'present' - Install package, ensure files are present (default)
#   * 'absent'  - Stop service and remove package and managed files
#
# [*package*]
#   Type: string
#   Manages the name of the package.
#
# [*version*]
#   Type: string, default: undef
#   If this value is set, the defined versoin of the package is installed.
#   Possible values are:
#   * 'x.y.z' - specific version
#   * latest  - latest available
#
# [*noops*]
#   Type: boolean, default: undef
#   Set noop metaparameter to true for all resources managed by the module.
#   If true no real change is done by the module on the system.
#
class unison (
  $ensure  = present,
  $package = 'unison227',
  $version = '',
  $noops   = undef,
) {

  ### Internal variables (that map class parameters)
  if $ensure == 'present' {
    $package_ensure = $version ? {
      ''      => 'present',
      default => $version,
    }
  } else {
    $package_ensure = 'absent'
  }

  package { 'unison':
    ensure => $package_ensure,
    name   => $package,
    noop   => $noops,
  }

}
# vi:syntax=puppet:filetype=puppet:ts=4:et:nowrap:
