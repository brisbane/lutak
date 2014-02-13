#
# = Class: desktop::evince
#
# This module installs evince
#
class desktop::evince {

  package { 'evince': ensure => present, }

}
