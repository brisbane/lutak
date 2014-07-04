# Class: aptrepo::carnet
#
# This module manages CARNet Debian repo
#
# Sample Usage:
#   include aptrepo::carnet
#

class aptrepo::carnet (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'carnet':
    location          => 'http://ftp.carnet.hr/carnet-debian/',
    release           => "carnet-${::lsbdistcodename}",
    repos             => 'main non-free',
    required_packages => 'carnet-keyring',
    key               => 'EC72006A',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
