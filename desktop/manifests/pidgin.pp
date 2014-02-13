#
# = Class: desktop::pidgin
#
# This module installs Pidgin & plugins
#
class desktop::pidgin {

  package { 'pidgin':             ensure => present, }
  package { 'pidgin-plugin_pack': ensure => present, }

}
