#
# = Class: java::slf4j
#
# This module installs slf4j lib for java
#
class java::slf4j {

  package { 'slf4j':
    ensure   => present,
  }
}
