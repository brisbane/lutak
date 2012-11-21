# Class: ossim
#
# This module manages ossim agent 
#
# Requires:
#
#

# Sample Usage:
#   include ossim
#
class ossim (
  $package_ensure   = $ossim::params::package_ensure,
  $agent_id         = $ossim::params::agent_id,
  $server_ip        = $ossim::params::server_ip,
  $sensor_ip        = $ossim::params::sensor_ip,
  $timezone         = $ossim::params::timezone,
  $include_snort    = $ossim::params::include_snort,
) inherits ossim::params {
  include geoip
  if $include_snort == true {
    include snort
    $snort_interfaces = $snort::interfaces
    snortunified{$snort_interfaces: }
  }
  package { 'ossim-agent':
    ensure  => $package_ensure,
    require => Package['GeoIP'],
  }
  file { '/etc/ossim/agent/config.cfg':
    ensure  => file,
    content => template('ossim/config.cfg.erb'),
    require => Package['ossim-agent'],
  }
}
