# Class: java::openjdk7
#
# This module manages openjdk package for Java7
#
class java::openjdk7 {
  package { 'java-1.7.0-openjdk':
    ensure   => present,
  }
  package { 'java-1.7.0-openjdk-devel':
    ensure   => present,
  }
}
