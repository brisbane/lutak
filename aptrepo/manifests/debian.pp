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
  include ::apt
  ::apt::source { 'debian':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => $::lsbdistcodename,
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
