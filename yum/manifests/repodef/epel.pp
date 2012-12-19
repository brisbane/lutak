# Class: yum::repodef::epel
#
# This module manages EPEL repo files for $lsbdistrelease
#
class yum::repodef::epel {
  require yum::repodef::base

  file { '/etc/yum.repos.d/epel.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/epel.repo",
    require => Package['epel-release'],
  }

  # install package depending on major version
  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package { 'epel-release':
        ensure   => present,
        provider => 'rpm',
        source   =>  'http://mirror.bytemark.co.uk/fedora/epel/5/i386/epel-release-5-4.noarch.rpm ',
      }
    }
    /^6.*/: {
      package { 'epel-release':
        ensure   => present,
        provider => 'rpm',
        source   => 'http://ftp-stud.hs-esslingen.de/pub/epel/6/i386/epel-release-6-7.noarch.rpm ',
      }
    }
  }
}
