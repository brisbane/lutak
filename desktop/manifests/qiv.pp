# = Class: desktop::qiv
#
# This module installs QIV
#
class desktop::qiv {

  package { 'qiv': ensure => present, }

}
