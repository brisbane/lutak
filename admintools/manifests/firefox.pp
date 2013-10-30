# Class: admintools::firefox
#
# This module manages Firefox
#
class admintools::firefox {

  package { 'firefox': ensure => present, }

}
