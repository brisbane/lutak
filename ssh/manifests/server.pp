# Class: ssh
#
# This module manages ssh
#
class ssh::server (
  $server_package_name = $ssh::server_package_name,
  $package_ensure      = $ssh::package_ensure,
  $service_name        = $ssh::service_name,
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
  # ssh keys
  file { '/etc/ssh/ssh_host_dsa_key':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    source  => [
      'puppet:///private/ssh/ssh_host_dsa_key',
      'puppet:///modules/ssh/ssh_host_dsa_key',
    ],
    require => Package['openssh-server'],
    notify  => Service[$service_name],
  }
  file { '/etc/ssh/ssh_host_dsa_key.pub':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => [
      'puppet:///private/ssh/ssh_host_dsa_key.pub',
      'puppet:///modules/ssh/ssh_host_dsa_key.pub',
    ],
    require => Package['openssh-server'],
    notify  => Service[$service_name],
  }
  file { '/etc/ssh/ssh_host_rsa_key':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    source  => [
      'puppet:///private/ssh/ssh_host_rsa_key',
      'puppet:///modules/ssh/ssh_host_rsa_key',
    ],
    require => Package['openssh-server'],
    notify  => Service[$service_name],
  }
  file { '/etc/ssh/ssh_host_rsa_key.pub':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => [
      'puppet:///private/ssh/ssh_host_rsa_key.pub',
      'puppet:///modules/ssh/ssh_host_rsa_key.pub',
    ],
    require => Package['openssh-server'],
    notify  => Service[$service_name],
  }

}



#   file { '/etc/ssh/ssh_config':
#     source  => $ssh_config_source,
#     require => Class['ssh::install'],
#     notify  => Service[$service_name],
#   }
#   file { '/etc/pam.d/ssh':
#     source  => 'puppet:///modules/ssh/etc/pam.d/ssh',
#     require => [ Class['ssh::install'], Class['libpam_radius_auth'] ],
#   }
