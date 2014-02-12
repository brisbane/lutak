#
# = Class: desktop::dm::xfdesktop
#
# Installs X Desktom Manager
class desktop::dm::xfdesktop {

  package { 'xfdesktop': ensure => present, }

}
