#
# = Class: tools::zbar
#
# This module manages zbar
#
class tools::zbar {
  package { 'zbar': ensure => present, }
}
