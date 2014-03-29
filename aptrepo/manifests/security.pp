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
  include ::apt
  ::apt::source { 'security':
    location          => 'http://security.debian.org/',
    release           => "${::lsbdistcodename}/updates",
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
