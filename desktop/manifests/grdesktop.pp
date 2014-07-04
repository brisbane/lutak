#
# = Class: desktop::grdesktop
#
# This module installs GTK Remote Desktop client
#
class desktop::grdesktop {

  include ::desktop::rdesktop
  package { 'grdesktop': ensure => present, }

}
