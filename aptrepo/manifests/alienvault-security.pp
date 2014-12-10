# Class: aptrepo::alienvault-security
#
# This module manages Alienvault repos
#
# Sample Usage:
#   include aptrepo::alienvault-security
#

class aptrepo::alienvault-security (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'alienvault-security':
    location    => 'http://data.alienvault.com/mirror/squeeze_security/',
    release     => "${::lsbdistcodename}/updates",
    repos       => 'main contrib',
    include_src => false,
  }
}
