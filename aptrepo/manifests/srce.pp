# Class: aptrepo::srce
#
# This module manages Srce Debian repo
#
# Sample Usage:
#   include aptrepo::srce
#

class aptrepo::srce (
  $stage = 'aptsetup',
){
  case $::operatingsystemmajrelease {
    default: {
      $debian_release = 'srce-wheezy'
    }
    /6/: {
      $debian_release = 'srce-squeeze'
    }
    /7/: {
      $debian_release = 'srce-wheezy'
    }
  }

  include ::apt
  ::apt::source { 'srce':
    location          => 'http://ftp.srce.hr/srce-debian/',
    release           => $debian_release,
    repos             => 'main mon',
    required_packages => 'srce-keyring',
    key               => '4089CBA3',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
