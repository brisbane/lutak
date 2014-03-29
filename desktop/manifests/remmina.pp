#
# = Class: desktop::remmina
#
# This module installs Remmina & plugins
#
class desktop::remmina {

  package { 'remmina':                    ensure => present, }
  package { 'remmina-plugins-nx':         ensure => present, }
  package { 'remmina-plugins-rdp':        ensure => present, }
  package { 'remmina-plugins-telepathy':  ensure => present, }
  package { 'remmina-plugins-vnc':        ensure => present, }
  package { 'remmina-plugins-xdmcp':      ensure => present, }

}
