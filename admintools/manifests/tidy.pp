# Class: admintools::tidy
#
# This module manages tidy
#
class admintools::tidy {
  package { 'tidy': ensure => present, }
}
