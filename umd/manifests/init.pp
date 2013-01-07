# Class: umd
#
# This modules deploys site-info.def file needed for UMD
# Yaim installation.
#
class umd {
  package { 'glite-yaim-core':
    ensure  => present,
  }

  file { '/opt/glite/yaim/etc/site-info.def':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    source  => 'puppet:///files/umd/site-info.def',
    require => Package['glite-yaim-core'],
  }
}
