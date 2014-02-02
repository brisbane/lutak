#
# = Class: desktop::pan
#
# This module installs PAN newsreader
#
class desktop::pan {

  package { 'pan': ensure => present, }

}
