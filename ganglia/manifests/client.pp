# Class: ganglia::client
#
# This class installs the ganglia client
#
# Parameters:
#   $cluster
#     default unspecified
#     this is the name of the cluster
#
#   $udp_port
#     default 8649
#     this is the udp port to multicast metrics on
#
# Actions:
#   installs the ganglia client
#
# Sample Usage:
#   include ganglia::client
#
#   or
#
#   class {'ganglia::client': cluster => 'mycluster' }
#
#   or
#
#   class {'ganglia::client':
#     cluster  => 'mycluster',
#     udp_port => '1234';
#   }
#
class ganglia::client (
  $cluster        = $ganglia::params::cluster,
  $owner          = $ganglia::params::owner,
  $udp_port       = $ganglia::params::udp_port,
  $tcp_port       = $ganglia::params::tcp_port,
  $udp_mcast_join = $ganglia::params::udp_mcast_join,
  $udp_bind       = $ganglia::params::udp_bind,
) inherits ganglia::params {
  package { 'ganglia-gmond':
    ensure   => present,
    notify   => Service['gmond'],
  }
  file { '/etc/ganglia/gmond.conf':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template('ganglia/gmond.conf'),
    require  => Package['ganglia-gmond'],
    notify   => Service['gmond'],
  }
  service {'gmond':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => File['/etc/ganglia/gmond.conf'],
  }
}
