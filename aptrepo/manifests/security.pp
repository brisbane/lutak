# Class: aptrepo::security
#
# This module manages Debian Security repo
#
# Sample Usage:
#   include aptrepo::security
#

class aptrepo::security (
  $stage = 'aptsetup',
){
  case $::operatingsystemmajrelease {
    default: {
      $debian_release = 'wheezy/updates'
    }
    /6/: {
      $debian_release = 'squeeze/updates'
    }
    /7/: {
      $debian_release = 'wheezy/updates'
    }
  }

  include ::apt
  ::apt::source { 'security':
    location          => 'http://security.debian.org/',
    release           => $debian_release,
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
