# Class: aptrepo::kamailio
#
# This module manages Kamailio repo
#
# Sample Usage:
#   include aptrepo::kamailio
#

class aptrepo::kamailio (
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
    location          => 'http://deb.kamailio.org/kamailio32/',
    release           => $debian_release,
    repos             => 'main',
    key               => '07D5C01D',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
