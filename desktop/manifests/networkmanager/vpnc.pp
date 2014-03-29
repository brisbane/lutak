#
# = Class: desktop::networkmanager::vpnc
#
# This module installs NetworkManager VPNC plugin (Cisco)_
#
class desktop::networkmanager::vpnc {

  package { 'NetworkManager-vpnc' : ensure => present, }

}
