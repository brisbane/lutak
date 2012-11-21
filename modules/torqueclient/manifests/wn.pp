# Class: torqueclient::wn
#
# This modules installs Torque WN
#

class torqueclient::wn {
  include torqueclient

  package { 'emi-wn':
    ensure  => latest,
    require => Class['torqueclient'],
  }
  file { '/opt/glite/yaim/etc/users.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => "puppet:///files/torqueclient/${::domain}/users.conf",
    require => Package['emi-wn'],
  }
  file { '/opt/glite/yaim/etc/wn-list.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => "puppet:///files/torqueclient/${::domain}/wn-list.conf",
    require => Package['emi-wn'],
  }
  exec { 'wnyaim':
    command => 'rpm -q emi-wn > /opt/glite/yaim/etc/emi-wn.info; /opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n WN -n TORQUE_client',
    unless  => 'test -f /opt/glite/yaim/etc/emi-wn.info &&  test \'`rpm -q emi-wn`\' = \'`cat /opt/glite/yaim/etc/emi-wn.info`\'',
    require => [ File['/opt/glite/yaim/etc/users.conf'], File['/opt/glite/yaim/etc/wn-list.conf'], ],
    timeout => 0,
  }
}
