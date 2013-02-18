# Class: umd
#
# This modules deploys site-info.def file needed for UMD
# Yaim installation.
#
class umd (
  $site_info_source = 'puppet:///files/umd/site-info.def',
) {
  package { 'glite-yaim-core':
    ensure  => present,
  }

  file { '/opt/glite/yaim/etc/site-info.def':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    source  => $site_info_source,
    require => Package['glite-yaim-core'],
  }
}
