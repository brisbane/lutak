# Class: torqueclient
#
# This modules installs Torque job submission tool
#

class torqueclient {
  #munge
  package { 'munge':
    ensure => present,
  }
  file { '/etc/munge/munge.key':
    ensure  => file,
    owner   => munge,
    group   => munge,
    mode    => '0400',
    source  => "puppet:///files/torqueclient/${::domain}/munge.key",
    require => Package['munge'],
  }
  service { 'munge':
    ensure  => running,
    enable  => true,
    require => File['/etc/munge/munge.key'],
  }

  # yaim
  package { 'glite-yaim-core':
    ensure => present,
  }

  # emi torque client
  package { 'emi-torque-client':
    ensure  => present,
    require => [ Package['glite-yaim-core'], Service['munge'], ],
  }
  file { '/opt/glite/yaim/etc/site-info.def':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => "puppet:///files/torqueclient/${::domain}/site-info.def",
    require => Package['emi-torque-client'],
  }
  file { '/var/lib/torque/mom_priv/config' :
    ensure  => absent,
    require => Package['emi-torque-client'],
  }
}
