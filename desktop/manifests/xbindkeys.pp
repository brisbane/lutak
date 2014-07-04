#
# = Class: desktop::xbindkeys
#
# This module installs xbindkeys
#
class desktop::xbindkeys {

  package { 'xbindkeys': ensure => present, }

}
