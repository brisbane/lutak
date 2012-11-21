# Class: scst
#
# This module deploys SCST target
#
class scst (
  $scstconf = 'scst/scst.conf.erb'
) inherits scst::params {
  package { 'scst-tools':
    ensure => present,
  }
  file { '/etc/scst.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template($scstconf),
    require => Package['scst-tools'],
    notify  => Service['scst'],
  }
  service { 'scst':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => File['/etc/scst.conf'],
  }
}
