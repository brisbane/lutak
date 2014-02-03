# Class: aptrepo::updates
#
# This module manages Debian Updates repo
#
# Sample Usage:
#   include aptrepo::updates
#

class aptrepo::updates {
  include ::apt
  ::apt::source { 'updates':
    location          => 'http://ftp.hr.debian.org/debian/',
    release           => 'wheezy-updates',
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring',
    key               => '381A7594',
    key_server        => 'pgp.mit.edu',
    pin               => '100',
    include_src       => true,
  }
}
