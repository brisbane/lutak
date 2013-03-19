# Class: Couchbase
#
# This module manages couchbase
#
class couchbase (
  $package_name   = 'couchbase-server',
  $package_vendor = 'community',
  $version        = '2.0.0',
  $build          = '1976',
  $server_user    = 'secret',
  $server_pass    = 'secret',
  $cluster_ip     = '',
) {
  require admintools::openssl098e

  # get correct package
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

  # stat service
  service { 'couchbase-server':
    ensure  => running,
    enable  => true,
    require => Package[$package_name],
  }

  # join cluster
  if $cluster_ip != '' {
    exec { 'join_couchbase_cluster':
      command => "/opt/couchbase/bin/couchbase-cli server-add -c ${cluster_ip}:8091 --server-add=${::ipaddress}:8091 -u ${server_user} -p ${server_pass}",
      unless  => "/opt/couchbase/bin/couchbase-cli server-list -c ${::ipaddress}:8091 >/dev/null -u ${server_user} -p ${server_pass}",
      require => Service['couchbase-server'],
    }
  }

}
# vi:nowrap
