#
# = Class: desktop::networkmanager
#
# This module installs NetworkManager
#
class desktop::networkmanager {

  package { 'NetworkManager': ensure => present, }

}
