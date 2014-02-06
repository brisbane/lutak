# Class: aptrepo::srce
#
# This module manages Srce Debian repo
#
# Sample Usage:
#   include aptrepo::srce
#

class aptrepo::srce {
  include ::apt
  ::apt::source { 'srce':
    location          => 'http://ftp.srce.hr/srce-debian/',
    release           => 'srce-wheezy',
    repos             => 'main mon',
    required_packages => 'srce-keyring',
    key               => '4089CBA3',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
