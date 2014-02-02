# = Class: desktop::smplayer
#
# This module installs Firefox
#
class desktop::smplayer {

  package { 'smplayer': ensure => present, }

}
