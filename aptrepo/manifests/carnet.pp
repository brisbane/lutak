# Class: aptrepo::carnet
#
# This module manages CARNet Debian repo
#
# Sample Usage:
#   include aptrepo::carnet
#

class aptrepo::carnet {
  include ::apt
  ::apt::source { 'carnet':
    location          => 'http://ftp.carnet.hr/carnet-debian/',
    release           => 'carnet-wheezy',
    repos             => 'main non-free',
    required_packages => 'carnet-keyring',
    key               => 'EC72006A',
    key_server        => 'pgp.mit.edu',
    pin               => '100',
    include_src       => true,
  }
}
