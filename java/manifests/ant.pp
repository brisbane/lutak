#
# = Class: java::ant
#
# This module installs Apache Ant
class java::ant {
  package { 'ant': ensure => present, }
}
