#
# = Class: desktop::kile
#
# This module installs Kile
#
class desktop::kile {

  package { 'kile': ensure => present, }

}
