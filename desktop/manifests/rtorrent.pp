#
# = Class: desktop::rtorrent
#
# This module installs rtorrent
#
class desktop::rtorrent {

  package { 'rtorrent':
    ensure => present,
  }

}
