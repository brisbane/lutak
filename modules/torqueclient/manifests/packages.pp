# Class: torqueclient::packages
#
# This modules installs Torque packages
#
class torqueclient::packages {
  include torqueclient::repos
  package { 'glite-yaim-core':
    ensure  => latest,
    require => Class['torqueclient::repos'],
  }
  package { 'emi-torque-client':
    ensure  => latest,
    require => Package['glite-yaim-core'],
  }
  file { '/opt/glite/yaim/etc/site-info.def' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => "puppet:///files/torqueclient/${::domain}/site-info.def",
    require => Package['emi-torque-client'],
  }
  exec { 'torqueyaim':
    command => 'rpm -q emi-torque-client > /opt/glite/yaim/etc/emi-torque-client.info; /opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n TORQUE_client',
    #ommand => 'rpm -q emi-torque-client > /opt/glite/yaim/etc/emi-torque-client.info; echo \'`date`\ nered pokrenut\' > /tmp/nered',
    unless  => 'test -f /opt/glite/yaim/etc/emi-torque-client.info &&  test \'`rpm -q emi-torque-client`\' = \'`cat /opt/glite/yaim/etc/emi-torque-client.info`\'',
    require => File['/opt/glite/yaim/etc/site-info.def'],
  }
}
