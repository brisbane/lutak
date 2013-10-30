# = Class: desktop::skype
#
# This module installs Skype
#
class desktop::skype {

  package { 'skype': ensure => present, }

}
