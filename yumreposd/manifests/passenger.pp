# Class: yumreposd::passenger
#
# This module manages Passenger repo files for $lsbdistrelease
# https://www.phusionpassenger.com/native_packages
#
class yumreposd::passenger {
  file { '/etc/yum.repos.d/passenger.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/passenger.repo",
    require => [ Package['passenger-release'], Class['yumreposd::base'] ],
  }

  # install package depending on major version
  case $::operatingsystemrelease {
    default : { }
    /^5.*/: {
      package { 'passenger-release' :
        ensure   => present,
        provider => 'rpm',
        source   => 'http://passenger.stealthymonkeys.com/rhel/5/passenger-release.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'passenger-release' :
        ensure   => present,
        provider => 'rpm',
        source   => 'http://passenger.stealthymonkeys.com/rhel/6/passenger-release.noarch.rpm',
      }
    }
  }
}
