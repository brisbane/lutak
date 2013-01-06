# Class: umd::wn
#
# This modules installs Torque WN
#
class umd::wn (
  $wn_version = '2.0.0-1.sl6',
  $torque_client_version = '1.0.0-2.sl6',
) inherits umd {
  include munge
  require gridcert::package

  # Packages needed for SAM jobs
  package { 'python-ldap':
    ensure  => latest,
  }
  package { 'openldap-client':
    ensure  => latest,
  }

  package { 'emi-wn':
    ensure  => $wn_version,
  }
  package { 'emi-torque-client':
    ensure  => $torque_client_version,
  }
  file { '/opt/glite/yaim/etc/users.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///files/umd/users.conf',
  }
  file { '/opt/glite/yaim/etc/groups.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///files/umd/groups.conf',
  }
  file { '/opt/glite/yaim/etc/wn-list.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///files/umd/wn-wn-list.conf',
  }

  exec { 'wn-yaim':
    command => 'rm -f /var/lib/torque/mom_priv/config; /opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n WN -n TORQUE_client && rpm -q emi-wn > /opt/glite/yaim/etc/emi-wn.info',
    unless  => 'test -f /opt/glite/yaim/etc/emi-wn.info',
    require => [ File['/opt/glite/yaim/etc/users.conf'], File['/opt/glite/yaim/etc/groups.conf'], Package['emi-wn'], Package['emi-torque-client'], Service['munge'] ],
    timeout => 0,
  }
}
