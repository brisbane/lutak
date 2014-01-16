# Class: tools::mysql::workbench
#
# This module installs mysql::workbench
#
class tools::mysql::workbench {
  package { 'mysql-workbench': ensure => present, }
}
