# Class: ssh
#
# This module manages ssh
#
class ssh::server (
  $server_package_name = $ssh::server_package_name,
  $package_ensure      = $ssh::package_ensure,
  $service_name        = $ssh::service_name,
  $keys_dir            = '/etc/puppet/private',
) inherits ssh {
  package { $server_package_name:
    ensure => $package_ensure,
  }
  service { $service_name:
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['openssh-server'],
  }

  if generate('/etc/puppet/modules/ssh/scripts/generate_host_keys.sh', "${keys_dir}/${::fqdn}/ssh") {
    include ssh::server::keys
  }
}
