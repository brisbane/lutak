# Class: aptrepo::debian
#
# This module manages Debian repo
#
# Sample Usage:
#   include aptrepo::debian
#

class aptrepo::debian {
  include ::apt
  ::apt::source { 'debian':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => 'wheezy',
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pgp.mit.edu',
    pin               => '100',
    include_src       => true,
  }
}
