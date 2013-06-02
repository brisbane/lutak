# Class: yum::repo::puppetlabls
#
# This module manages PuppetLabs repo files for $lsbdistrelease
#
class yum::repo::puppetlabs (
  $stage = 'yumsetup'
) {
  require yum::repo::base

  file { '/etc/yum.repos.d/puppetlabs.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/puppetlabs.repo",
    require => Package['puppetlabs-release'],
  }

  # install package depending on major version
  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package { 'puppetlabs-release' :
        ensure   => '5-7',
        provider => 'rpm',
        source   => 'http://yum.puppetlabs.com/el/5/products/x86_64/puppetlabs-release-5-7.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'puppetlabs-release' :
        ensure   => '6-7',
        provider => 'rpm',
        source   => 'http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm',
      }
    }
  }
}
