#
# = Class: desktop::dm::gdm
#
# Installs Gnome Desktom Manager
class desktop::dm::gdm {

  package { 'gdm': ensure => present, }

}
