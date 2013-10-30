# Class: tools::mlocate
#
# This module installs mlocate
#
class tools::mlocate {
  package { 'mlocate': ensure => present, }
}
