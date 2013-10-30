#
# = Class: desktop::networkmanager::gnome
#
# This module installs NetworkManager Gnome plugin
#
class desktop::networkmanager::gnome {

  package { 'NetworkManager-gnome' : ensure => present, }

}
