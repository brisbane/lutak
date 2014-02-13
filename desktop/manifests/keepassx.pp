# = Class: desktop::keepassx
#
# This module installs keepassx
#
class desktop::keepassx {

  package { 'keepassx': ensure => present, }

}
