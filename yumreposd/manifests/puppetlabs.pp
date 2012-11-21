# Class: yumreposd::puppetlabls
#
# This module manages PuppetLabs repo files for $lsbdistrelease
#
class yumreposd::puppetlabs {
  file { '/etc/yum.repos.d/puppetlabs.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/puppetlabs.repo",
    require => [ Package['puppetlabs-release'], Class['yumreposd::base'] ],
  }

  # install package depending on major version
  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package { 'puppetlabs-release' :
        ensure   => '5-6',
        provider => 'rpm',
        source   => 'http://yum.puppetlabs.com/el/5/products/x86_64/puppetlabs-release-5-6.noarch.rpm',
      }
    }
    /^6.*/: {
      package { 'puppetlabs-release' :
        ensure   => '6-6',
        provider => 'rpm',
        source   => 'http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-6.noarch.rpm',
      }
    }
  }
}
