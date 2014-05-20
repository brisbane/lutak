# Class: Couchbase
#
# This module manages couchbase
#
class couchbase (
  $package_name   = 'couchbase-server',
  $package_vendor = 'community',
  $version        = '2.0.0',
  $release        = '1976',
  $package_source = 'http://packages.couchbase.com/releases/2.0.0/couchbase-server-community-_x86_64_2.0.0.rpm',
  $server_user    = 'secret',
  $server_pass    = 'secret',
  $cluster_ip     = '',
) {
  require ::admintools::openssl098e

  Couchbucket {
    admin_user     => $server_user,
    admin_password => $server_pass,
  }

  # get correct package
  package { $package_name :
    ensure   => "${version}-${release}",
    provider => 'rpm',
    source   => $package_source,
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
