# Class: aptrepo::debian
#
# This module manages Debian repo
#
# Sample Usage:
#   include aptrepo::debian
#

class aptrepo::debian (
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
  ::apt::source { 'debian':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => $debian_release,
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
