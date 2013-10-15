# Class: admintools::zbar
#
# This module manages zbar
#
class admintools::zbar {
  package { 'zbar': ensure => present, }
}
