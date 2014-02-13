# Class: aptrepo::backports
#
# This module manages Debian Backports repo
#
# Sample Usage:
#   include aptrepo::backports
#

class aptrepo::backports (
  $stage = 'aptsetup',
){
  case $::operatingsystemmajrelease {
    default: {
      $debian_release = 'wheezy-backports'
    }
    /6/: {
      $debian_release = 'squeeze-backports'
    }
    /7/: {
      $debian_release = 'wheezy-backports'
    }
  }

  include ::apt
  ::apt::source { 'backports':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => $debian_release,
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
