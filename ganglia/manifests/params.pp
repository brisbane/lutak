# Class: ganglia::params
class ganglia::params {
  $grid                   = ''
  $cluster                = 'undefined'
  $owner                  = 'undefined'
  $udp_port               = '8649'
  $tcp_port               = '8649'
  $udp_mcast_join         = '239.2.11.71'
  $udp_bind               = '239.2.11.71'
  $udp_host               = ''
  $unicast                = false
  $mute                   = 'no'
  $deaf                   = 'no'
  $send_metadata_interval = '0'
  $tcp_accept_channel     = true
  $package_ensure         = '3.6.0-1.el6.srce'
  $udphosts               = undef
  $override_hostname      = undef
}
