# = Class: desktop::k3b
#
# This module installs k3b
#
class desktop::k3b {

  package { 'k3b': ensure => present, }

}
