# = Class: desktop::dia
#
# This module installs Dia
#
class desktop::dia {

  package { 'dia': ensure => present, }

}
