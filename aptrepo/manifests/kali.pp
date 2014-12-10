# Class: aptrepo::kali
#
# This module manages Kali repo
#
# Sample Usage:
#   include aptrepo::kali
#

class aptrepo::kali (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'kali':
    location          => 'http://http.kali.org/kali',
    release           => $::lsbdistcodename,
    repos             => 'kali main contrib non-free',
    required_packages => 'kali-archive-keyring',
    key               => '7D8D0BF6',
    key_server        => 'pks.aaiedu.hr',
    include_src       => false,
  }
}
