# Class: ganglia::server
#
# This class installs the ganglia server
#
# Parameters:
#
# Actions:
#   installs the ganglia server
#
# Sample Usage:
#   include ganglia::server
#
class ganglia::server (
  $cluster        = $ganglia::params::cluster
) inherits ganglia::params {
  package { 'ganglia-gmetad':
    ensure => present,
  }
  file { '/etc/ganglia/gmetad.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('ganglia/gmetad.conf'),
    require => Package['ganglia-gmetad'],
    notify  => Service['gmetad'],
  }
  service {'gmetad':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => File['/etc/ganglia/gmetad.conf'],
  }
}

