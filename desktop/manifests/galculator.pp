# = Class: desktop::galculator
#
# This module installs galculator
#
class desktop::galculator {

  package { 'galculator': ensure => present, }

}
