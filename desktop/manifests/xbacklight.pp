#
# = Class: desktop::xbacklight
#
# This module installs xbacklight
#
class desktop::xbacklight {

  package { 'xbacklight': ensure => present, }

}
