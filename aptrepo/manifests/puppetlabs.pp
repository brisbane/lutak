# Class: aptrepo::puppetlabs
#
# This module manages Puppetlabs repo
#
# Sample Usage:
#   include aptrepo::puppetlabs
#

class aptrepo::puppetlabs (
  $stage = 'aptsetup',
){
  case $::operatingsystemmajrelease {
    default: {
      $debian_release = 'wheezy'
    }
    /6/: {
      $debian_release = 'squeeze'
    }
    /7/: {
      $debian_release = 'wheezy'
    }
  }

  include ::apt
  ::apt::source { 'puppetlabs':
    location          => 'http://apt.puppetlabs.com/',
    release           => $debian_release,
    repos             => 'main dependencies',
    key               => '4BD6EC30',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
