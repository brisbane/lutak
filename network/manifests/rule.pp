# Definition: network::rule
#
# Configures /etc/sysconfig/networking-scripts/rule-$name
#
# Parameters:
#   $iprule - required
#
# Actions:
#
# Requires:
#   File["ifcfg-$name"]
#
# Sample Usage:
#   # interface rule
#   network::rule { 'eth0':
#     iprule => 'fwmark 0x99 lookup custom_table',
#   }
#
define network::rule (
  $iprule,
  ) {
  $interface = $name

  file { "rule-${interface}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    path    => "/etc/sysconfig/network-scripts/rule-${interface}",
    content => template('network/rule-eth.erb'),
    before  => File["ifcfg-${interface}"],
  }
}
