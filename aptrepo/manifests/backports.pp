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
  case $::lsbdistcodename {
    default: {
      $debian_location = 'http://ftp.hr.debian.org/debian/'
    }
    /squeeze/: {
      $debian_location = 'http://backports.debian.org/debian-backports/'
    }
    /wheezy/: {
      $debian_location = 'http://ftp.hr.debian.org/debian/'
    }
  }

  include ::apt
  ::apt::source { 'backports':
    location          => $debian_location,
    release           => "${::lsbdistcodename}-backports",
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
