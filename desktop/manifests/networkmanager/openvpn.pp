#
# = Class: desktop::networkmanager::openvpn
#
# This module installs NetworkManager OpenVPN plugin
#
class desktop::networkmanager::openvpn {

  package { 'NetworkManager-openvpn' : ensure => present, }

}
