# Class: aptrepo::gluster
#
# This module manages GlusterFS repo
#
# Sample Usage:
#   include aptrepo::gluster
#

class aptrepo::gluster (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'gluster':
    location     => 'http://download.gluster.org/pub/gluster/glusterfs/3.4/3.4.5/Debian/wheezy/apt',
    release      => $::lsbdistcodename,
    architecture => 'amd64',
    repos        => 'main',
    key          => '21C74DF2',
    key_server   => 'keys.gnupg.net',
    include_src  => true,
  }
}
