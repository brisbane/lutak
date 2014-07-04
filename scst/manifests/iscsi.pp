# Class: scst::iscsi
#
# This module deploys SCST iscsi target
#
class scst::iscsi (
  $load_nfsordma = $infiniband::params::load_nfsordma,
) inherits scst::params {
  package { 'scst-tools':
    ensure => present,
  }
  file { '/etc/scst.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('scst/scst.conf.erb'),
    require => Package['scst-tools'],
  }
  service { 'scst':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => File['/etc/scst.conf'],
  }
}
