#
# = Class: desktop::oxygen
#
# This module installs Oxygen themes
#
class desktop::oxygen {

  package { 'oxygen-cursor-themes': ensure => present, }
  package { 'oxygen-icon-theme':    ensure => present, }

}
