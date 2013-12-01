#
# = Class: rsyslog::central
#
# This class manages separate rsyslog service that drops
# privileges and acts as central logging system.
class rsyslog::central (
  $service          = 'rsyslog-central',
  $syslogd_options  = '-c 5',
  $config_file      = '/etc/rsyslog-central.conf',
  $datadir          = '/var/lib/syslog',
  $user             = 'rsyslog',
  $group            = 'rsyslog',
  $uid              = '98',
  $gid              = '98',
  $tcp_port         = '10514',
  $udp_port         = '514',
  $file_create_mode = '0640',
  $dir_create_mode  = '0700',
  $umask            = '0077',
) {
  include ::rsyslog

  File {
    owner => root,
    group => root,
    mode  => '0644',
  }

  file { $datadir :
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  file { "/etc/init.d/${service}" :
    mode   => '0755',
    source => 'puppet:///modules/rsyslog/central.init'
  }

  file { "/etc/sysconfig/${service}" :
    content => template('rsyslog/central.sysconfig.erb'),
    notify  => Service[$service],
  }

  file { $config_file :
    content => template('rsyslog/central.conf.erb'),
    notify  => Service[$service],
  }

  group { $user :
    ensure => present,
    gid    => $gid,
    system => true,
  }

  user { $group :
    ensure     => present,
    comment    => 'Central syslog user',
    uid        => $uid,
    gid        => $gid,
    system     => true,
    home       => $datadir,
    managehome => false,
    shell      => '/sbin/nologin',
  }

  service { $service :
    ensure  => running,
    enable  => true,
    require => [
      Group[$group],
      User[$user],
    ],
  }

}
