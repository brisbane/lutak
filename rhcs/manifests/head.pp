# Class: rhcs::head
#
# This module deploys base RedHah Cluster Suite packages
#
class rhcs::head inherits rhcs{
  file {'/etc/cluster.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => $rhcs::config_file,
    require => Package['cman'],
  }
  exec {'clusterupdate' :
    cmd         => 'cman_tool version -r',
    refreshonly => true,
    subscribe   => File['/etc/cluster.conf'],
    require     => Service['cman'],
  }
}
