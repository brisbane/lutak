# Class: admintools::findutils
#
# This modules installs extra administration utilities
#
class admintools::findutils {
  package { 'mlocate': ensure  => present, }
}
