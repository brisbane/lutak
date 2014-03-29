#
# = Class: desktop::xclip
#
# This module installs xclip (X Clipboard)
#
class desktop::xclip {

  package { 'xclip': ensure => present, }

}
