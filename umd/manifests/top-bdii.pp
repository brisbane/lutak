# Class: umd::top-bdii
#
# This modules installs UMD Top BDII
#

class umd::top-bdii (
  $bdii_version   = present,
  $manual_file    = '',
  $endpoints_conf = '',
) inherits umd {
  package { 'emi-bdii-top':
    ensure  => $bdii_version,
  }
  exec { 'bdii-yaim':
    command => '/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n BDII_top && rpm -q emi-bdii-top > /opt/glite/yaim/etc/emi-bdii-top.info',
    unless  => 'test -f /opt/glite/yaim/etc/emi-bdii-top.info',
    require => [ File['/opt/glite/yaim/etc/site-info.def'], Package['emi-bdii-top'] ],
    timeout => 0,
  }
  service { 'bdii':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Exec['bdii-yaim'],
  }
  if $endpoints_conf != '' {
    file { '/etc/glite/glite-info-update-endpoints.conf':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      source  => $endpoints_conf,
      require => Package['emi-bdii-top'],
      notify  => Service['bdii'],
    }
  }
  if $manual_file != '' {
    file { '/etc/glite/top-urls.conf':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0644',
      source  => $manual_file,
      require => Package['emi-bdii-top'],
      notify  => Service['bdii'],
    }
  }
}
