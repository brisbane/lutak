# = Class: desktop::gimp
#
# This module installs gimp
#
class desktop::gimp {

  package { 'gimp': ensure => present, }

}
