# Class: umd::wn
#
# This modules installs Torque WN
#
class umd::wn (
  $wn_version = 'present',
  $torque_client_version = 'present',
) inherits umd {
  include munge
  require gridcert::package

  # Packages needed for SAM jobs
  package { 'python-ldap':
    ensure  => latest,
  }
  package { 'openldap-clients':
    ensure  => latest,
  }
  package { 'perl-XML-Parser':
    ensure  => latest,
  }

  # Needed for jobwrapper
  package { 'glite-lb-client-progs':
    ensure  => latest,
  }

  package { 'emi-wn':
    ensure  => $wn_version,
  }
  package { 'emi-torque-client':
    ensure  => $torque_client_version,
  }
  file { '/opt/glite/yaim/etc/users.conf':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///files/umd/users.conf',
  }
  file { '/opt/glite/yaim/etc/groups.conf':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///files/umd/groups.conf',
  }
  file { '/opt/glite/yaim/etc/wn-list.conf':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///files/umd/wn-wn-list.conf',
  }
  exec { 'wn-yaim':
    command => 'rm -f /var/lib/torque/mom_priv/config; /opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n WN -n TORQUE_client && rpm -q emi-wn > /opt/glite/yaim/etc/emi-wn.info',
    unless  => 'test -f /opt/glite/yaim/etc/emi-wn.info',
    require => [ File['/opt/glite/yaim/etc/users.conf'], File['/opt/glite/yaim/etc/groups.conf'], Package['emi-wn'], Package['emi-torque-client'], Service['munge'], File['/opt/glite/yaim/functions/local/config_torque_client'] ],
    timeout => 0,
  }
  file { '/opt/glite/yaim/functions/local/config_torque_client':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/umd/config_torque_client',
  }
  file { '/etc/profile.d/glite_local.sh':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/umd/glite_local.sh',
  }
  file { '/etc/profile.d/glite_local.csh':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/umd/glite_local.csh',
  }
  file { '/usr/local/libexec/cp_1.sh':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/umd/cp_1.sh',
  }

}
