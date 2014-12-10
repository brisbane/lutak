# Class: aptrepo::openvas
#
# This module manages OpenVAS repo
#
# Sample Usage:
#   include aptrepo::openvas
#

class aptrepo::openvas (
  $stage = 'aptsetup',
){
  include ::apt
  ::apt::source { 'openvas':
    location    => 'http://download.opensuse.org/repositories/security:/OpenVAS:/UNSTABLE:/v6/Debian_7.0/',
    release     => './',
    repos       => '',
    key         => '79EAFD54',
    key_server  => 'keys.gnupg.net',
    include_src => false,
  }
}
