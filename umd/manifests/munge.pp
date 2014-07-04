# Class: umd::munge
#
# This modules installs Munge needed for Torque
#
class umd::munge {
  package { 'munge':
    ensure => present,
  }
  file { '/etc/munge/munge.key':
    ensure  => file,
    owner   => munge,
    group   => munge,
    mode    => '0400',
    source  => "puppet:///files/umd/${::domain}/munge.key",
    require => Package['munge'],
  }
  service { 'munge':
    ensure  => running,
    enable  => true,
    require => File['/etc/munge/munge.key'],
  }
}
