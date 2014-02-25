# Class: aptrepo::kamailio
#
# This module manages Kamailio repo
#
# Sample Usage:
#   include aptrepo::kamailio
#

class aptrepo::kamailio (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'kamailio':
    location          => 'http://deb.kamailio.org/kamailio32/',
    release           => $::lsbdistcodename,
    repos             => 'main',
    key               => '07D5C01D',
    key_server        => 'pks.aaiedu.hr',
    include_src       => true,
  }
}
