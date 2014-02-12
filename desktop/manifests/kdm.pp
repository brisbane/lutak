# = Class: desktop::kdm
#
# This module installs KDE Desktop Manager
#
class desktop::kdm {

  package { 'kdm': ensure => present, }

}
