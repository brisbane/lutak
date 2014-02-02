#
# = Class: desktop::rdesktop
#
# This module installs Remote Desktop client
#
class desktop::rdesktop {

  package { 'rdesktop': ensure => present, }

}
