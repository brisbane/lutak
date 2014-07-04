#
# = Class: desktop::networkmanager::pptp
#
# This module installs NetworkManager PPTP plugin
#
class desktop::networkmanager::pptp {

  package { 'NetworkManager-pptp' : ensure => present, }

}
