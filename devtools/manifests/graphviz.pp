# Class: devtools::graphviz
#
# This module manages graphviz
#
class devtools::graphviz {
  package { 'graphviz': ensure => present, }
}
