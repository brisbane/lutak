# Class: aptrepo::puppetlabs
#
# This module manages Puppetlabs repo
#
# Sample Usage:
#   include aptrepo::puppetlabs
#

class aptrepo::puppetlabs (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'puppetlabs':
    location          => 'http://apt.puppetlabs.com/',
    release           => 'wheezy',
    repos             => 'main dependencies',
    key               => '4BD6EC30',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
