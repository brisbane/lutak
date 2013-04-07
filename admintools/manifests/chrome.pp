# Class: admintools::chrome
#
# This module manages Google Chome
#
class admintools::chrome {

  package { 'google-chrome-stable': ensure => present, }

}
