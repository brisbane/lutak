# Class: aptrepo::backports
#
# This module manages Debian Backports repo
#
# Sample Usage:
#   include aptrepo::backports
#

class aptrepo::backports {
  include ::apt
  ::apt::source { 'backports':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => 'wheezy-backports',
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pgp.mit.edu',
    pin               => '100',
    include_src       => true,
  }
}
