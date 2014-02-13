# Class: aptrepo::carnet
#
# This module manages CARNet Debian repo
#
# Sample Usage:
#   include aptrepo::carnet
#

class aptrepo::carnet (
  $stage = 'aptsetup',
){
  case $::operatingsystemmajrelease {
    default: {
      $debian_release = 'carnet-wheezy'
    }
    /6/: {
      $debian_release = 'carnet-squeeze'
    }
    /7/: {
      $debian_release = 'carnet-wheezy'
    }
  }

  include ::apt
  ::apt::source { 'carnet':
    location          => 'http://ftp.carnet.hr/carnet-debian/',
    release           => $debian_release,
    repos             => 'main non-free',
    required_packages => 'carnet-keyring',
    key               => 'EC72006A',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
