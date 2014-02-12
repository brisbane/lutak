# = Class: desktop::firefox
#
# This module installs Firefox
#
class desktop::firefox {

  package { 'firefox': ensure => present, }

}
