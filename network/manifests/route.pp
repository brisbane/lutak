# Definition: network::route
#
# Configures /etc/sysconfig/networking-scripts/route-$name
#
# Parameters:
#   $address - required
#   $netmask - required
#   $gateway - required
#
# Actions:
#
# Requires:
#   File["ifcfg-$name"]
#
# Sample Usage:
#   # interface routes
#   network::route { 'eth0':
#     address => [ "192.168.2.0", "10.0.0.0", ],
#     netmask => [ "255.255.255.0", "255.0.0.0", ],
#     gateway => [ "192.168.1.1", "10.0.0.1", ],
#   }
#   # interface routes
#   network::route { 'eth0':
#     iproute => [
#       '192.168.2.0/24 via 192.168.1.1',
#       '10.0.0.0/8 via 10.0.0.1',
#     ],
#   }
#
define network::route (
  $address = '',
  $netmask = '',
  $gateway = '',
  $iproute = '',
) {
  $interface = $name

  File {
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
  }

  if $iproute != '' {
    file { "route-${interface}":
      path    => "/etc/sysconfig/network-scripts/route-${interface}",
      content => template('network/route-eth.erb'),
      before  => File["ifcfg-${interface}"],
    }
  } else {
    file { "route-${interface}":
      path    => "/etc/sysconfig/network-scripts/route-${interface}",
      content => template('network/route-eth-adr.erb'),
      before  => File["ifcfg-${interface}"],
    }
  }

}
