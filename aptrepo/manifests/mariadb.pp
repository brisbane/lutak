# Class: aptrepo::mariadb
#
# This module manages MariaDB repo
#
# Sample Usage:
#   include aptrepo::mariadb
#

class aptrepo::mariadb (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'mariadb':
    location     => 'http://mariadb.cu.be/repo/5.5/debian',
    release      => $::lsbdistcodename,
    architecture => 'amd64',
    repos        => 'main',
    key          => '0xcbcb082a1bb943db',
    key_server   => 'keyserver.ubuntu.com',
    include_src  => true,
  }
}
