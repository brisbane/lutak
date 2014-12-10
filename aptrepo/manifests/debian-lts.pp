# Class: aptrepo::debian-lts
#
# This module manages Debian repo
#
# Sample Usage:
#   include aptrepo::debian-lts
#

class aptrepo::debian-lts (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'debian-lts':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => "${::lsbdistcodename}-lts",
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
