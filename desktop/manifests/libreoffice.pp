#
# = Class: desktop::libreoffice
#
# This module installs Remote Desktop client
#
class desktop::libreoffice {

  package { 'libreoffice': ensure => present, }

}
