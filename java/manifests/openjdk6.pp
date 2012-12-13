# Class: java::openjdk6
#
# This module manages openjdk package for Java6
#
class java::openjdk6 {
  package { 'java-1.6.0-openjdk':
    ensure   => present,
  }
  package { 'java-1.6.0-openjdk-devel':
    ensure   => present,
  }
}
