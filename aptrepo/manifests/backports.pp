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
  include ::apt
  ::apt::source { 'backports':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => 'wheezy-backports',
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
