#
# = Class: sysfs::base
#
# Install sysfsutils
#
class sysfs::base {

  File {
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['sysfsutils'],
  }

  package { 'sysfsutils':
    ensure => present,
  }

  file { '/etc/sysfs.conf':
    source  => 'puppet:///modules/sysfs/sysfs.conf',
  }

  file { '/etc/sysfs.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

  if $::osfamily == 'RedHat' {
    file { '/etc/init.d/sysfsutils':
      mode   => '0755',
      source => "puppet:///modules/sysfs/init.${::osfamily}",
      before => Service['sysfsutils'],
    }
  }

  service { 'sysfsutils':
    ensure  => running,
    enable  => true,
  }

}
