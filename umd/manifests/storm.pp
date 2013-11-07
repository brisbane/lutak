# Class: umd::storm
#
# This modules installs UMD StoRM
#
class umd::storm (
  $storm_version = '1.2.0-4.el6',
  $storm_https_version = '1.0.0-3.el6',
  $apel_version = '1.0.0-0.sl6',
  $bdii_version = '1.0.1-1.el6',
) inherits umd {
  require gridcert
  package { 'emi-storm-backend-mp':
    ensure  => $storm_version,
  }
  package { 'emi-storm-frontend-mp':
    ensure  => $storm_version,
  }
  package { 'emi-storm-globus-gridftp-mp':
    ensure  => $storm_version,
  }
  package { 'emi-storm-gridhttps-mp':
    ensure  => $storm_https_version,
  }
  package { 'storm-pre-assembled-configuration':
    ensure  => present,
  }
  package { 'emi-apel':
    ensure  => $apel_version,
  }
  package { 'emi-bdii-site':
    ensure  => $bdii_version,
  }
  file { '/opt/glite/yaim/etc/users.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///files/umd/users.conf',
    require => Package['emi-storm-backend-mp'],
  }
  file { '/opt/glite/yaim/etc/groups.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///files/umd/groups.conf',
    require => Package['emi-storm-backend-mp'],
  }
  exec { 'creamce-yaim':
    command => '/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n se_storm_backend -n se_storm_frontend -n se_storm_gridftp -n se_storm_gridhttps -n APEL -n BDII_site && rpm -q emi-storm-backend-mp > /opt/glite/yaim/etc/emi-storm-backend-mp.info',
    unless  => 'test -f /opt/glite/yaim/etc/emi-storm-backend-mp.info',
    require => [ File['/opt/glite/yaim/etc/users.conf'], File['/opt/glite/yaim/etc/groups.conf'], Package['emi-storm-backend-mp'], Package['emi-storm-frontend-mp'], Package['emi-storm-globus-gridftp-mp'], Package['emi-storm-gridhttps-mp'], Package['emi-apel'], Package['emi-bdii-site'] ],
    timeout => 0,
  }
}
