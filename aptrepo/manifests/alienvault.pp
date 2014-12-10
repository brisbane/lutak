# Class: aptrepo::alienvault
#
# This module manages Alienvault repos
#
# Sample Usage:
#   include aptrepo::alienvault
#

class aptrepo::alienvault (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'alienvault':
    location    => 'http://data.alienvault.com/mirror/squeeze/',
    release     => $::lsbdistcodename,
    repos       => 'main contrib',
    include_src => false,
  }
}
