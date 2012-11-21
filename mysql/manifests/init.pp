# Class: mysql
#
# This module manages mysql
#
class mysql {
  # packages from CentOS base
  package { 'mysql': ensure => present, }
}
