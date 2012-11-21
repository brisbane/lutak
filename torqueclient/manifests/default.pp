# Class: torqueclient
#
# This modules installs Torque job submission tool
#

class torqueclient::default {
  include torqueclient
  exec { 'torqueyaim':
    command => "rpm -q emi-torque-client > /opt/glite/yaim/etc/emi-torque-client.info; /opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n TORQUE_client",
    unless  => "test -f /opt/glite/yaim/etc/emi-torque-client.info &&  test \"`rpm -q emi-torque-client`\" = \"`cat /opt/glite/yaim/etc/emi-torque-client.info`\"",
    require => [ File['/opt/glite/yaim/etc/site-info.def'], File['/var/lib/torque/mom_priv/config'], ],
    timeout => 0,
  }
}
