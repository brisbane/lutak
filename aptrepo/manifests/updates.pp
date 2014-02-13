# Class: aptrepo::updates
#
# This module manages Debian Updates repo
#
# Sample Usage:
#   include aptrepo::updates
#

class aptrepo::updates (
  $stage = 'aptsetup',
){
  case $::operatingsystemmajrelease {
    default: {
      $debian_release = 'wheezy-updates'
    }
    /6/: {
      $debian_release = 'squeeze-updates'
    }
    /7/: {
      $debian_release = 'wheezy-updates'
    }
  }

  include ::apt
  ::apt::source { 'updates':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => $debian_release,
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
