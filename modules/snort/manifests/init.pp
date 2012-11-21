# Class: snort
#
# This module manages snort package
#
class snort (
  $logdir         = $snort::params::logdir,
  $interfaces     = $snort::params::interfaces,
  $home_net       = $snort::params::home_net,
  $dns_servers    = $snort::params::dns_servers,
  $smtp_servers   = $snort::params::smtp_servers,
  $http_servers   = $snort::params::http_servers,
  $sql_servers    = $snort::params::sql_servers,
  $ftp_servers    = $snort::params::ftp_servers,
  $telnet_servers = $snort::params::telnet_servers,
  $oinkcode       = $snort::params::oinkcode,
  $ppork_ignore   = $snort::params::ppork_ignore,
  ) inherits snort::params {
  package { 'snort':
    ensure  => present,
  }
  file { '/etc/snort/snort.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('snort/snort.conf.erb'),
    require => Package['snort'],
    notify  => Service['snortd'],
  }
  file { '/etc/sysconfig/snort':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('snort/snort.sysconfig.erb'),
    require => Package['snort'],
    notify  => Service['snortd'],
  }
  file { '/etc/snort/local.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => "puppet:///files/snort/${::fqdn}/local.conf",
    require => [ Package['snort'], File['/etc/snort/snort.conf'] ],
    notify  => Service['snortd'],
  }
  file { '/etc/snort/rules/local.rules':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => "puppet:///files/snort/${::fqdn}/local.rules",
    require => [ Package['snort'], File['/etc/snort/local.conf'] ],
    notify  => Service['snortd'],
  }
  file { "$logdir":
    ensure  => directory,
    owner   => snortd,
    group   => snortd,
    mode    => '0750',
    require => Package['snort'],
  }
  service { 'snortd':
    ensure  => running,
    enable  => true,
    require => File["$logdir", '/etc/snort/rules/local.rules' ],
  }
}
