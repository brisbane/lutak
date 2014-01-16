# = Class: desktop::qbittorrent
#
# This module installs Firefox
#
class desktop::qbittorrent {

  package { 'qbittorrent': ensure => present, }

}
