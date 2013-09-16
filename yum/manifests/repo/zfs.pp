#
# = Class: yum::repo::zfs
#
# This class manages ZFS repo files for $lsbdistrelease
#
class yum::repo::zfs (
  $stage    = 'yumsetup',
  $priority = '99',
  $exclude  = [],
) {
  file { '/etc/yum.repos.d/zfs.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/zfs.erb"),
    require => Package['zfs-release'],
  }

  # install package depending on major version
  case $::operatingsystemrelease {
    default: {}
    /^6.*/: {
      package { 'zfs-release':
        ensure   => present,
        provider => 'rpm',
        source   => 'http://archive.zfsonlinux.org/epel/zfs-release-1-2.el6.noarch.rpm',
      }
    }
  }
}