# Class: lvm
class lvm (
  $package_name = $lvm::params::package_name,
) inherits lvm::params {
  package { 'lvm':
    ensure => present,
    name   => $package_name,
  }
}
