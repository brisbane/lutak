# Class: hpccluster
#
# Module for including packages for HPC cluster
#
class hpccluster (
  $packages = '',
) {
  # install packages
  package { $packages:
    ensure => present,
  }
}
