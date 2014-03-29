#
# = Class: desktop::dm::xdm
#
# Installs X Desktom Manager
class desktop::dm::xdm {

  package { 'xdm': ensure => present, }

}
