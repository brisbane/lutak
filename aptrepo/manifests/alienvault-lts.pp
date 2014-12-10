# Class: aptrepo::alienvault-lts
#
# This module manages Alienvault repos
#
# Sample Usage:
#   include aptrepo::alienvault-lts
#

class aptrepo::alienvault-lts (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'alienvault-lts':
    location    => 'http://data.alienvault.com/mirror/squeeze_lts/',
    release     => "${::lsbdistcodename}-lts",
    repos       => 'main contrib',
    include_src => false,
  }
}
