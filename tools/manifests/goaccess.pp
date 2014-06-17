#
# = Class: tools::goaccess
#
# This module manages GoAcess, interactive apache log viewer
#
class tools::goaccess {

  package { 'goaccess': ensure => present, }

}
