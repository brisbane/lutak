# Class: Couchbase
#
# This module manages couchbase
#
class couchbase (
  $package_name   = 'couchbase-server',
  $package_vendor = 'community',
  $version        = '2.0.0',
  $build          = '1976',
) {

  case $::architecture {
    default: {}
    /^i386/: {
      package { $package_name :
        ensure   => "${version}-${build}",
        provider => 'rpm',
        source   => "http://packages.couchbase.com/releases/2.0.0/${package_name}-${package_vendor}_x86_${version}.rpm",
      }
    }
    /^x86_64/: {
      package { $package_name :
        ensure   => "${version}-${build}",
        provider => 'rpm',
        source   => "http://packages.couchbase.com/releases/2.0.0/${package_name}-${package_vendor}_x86_64_${version}.rpm",
      }
    }
  }

  service { 'couchbase-server':
    ensure  => running,
    enable  => true,
    require => Package[$package_name],
  }

}
