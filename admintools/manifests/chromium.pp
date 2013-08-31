# Class: admintools::chromium
#
# This module manages Google Chome
#
class admintools::chromium {

  require ::yum::repo::russian::updates::testing
  package { 'chromium': ensure => present, }

}
