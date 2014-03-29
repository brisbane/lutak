# Class: java::oracle6
#
# This module manages java-oracle package from srce repo for Java 6
#
class java::oracle7 {
  require yum::repo::srce::intern

  package { 'java-1.7.0-oracle':
    ensure   => present,
  }
  package { 'java-1.7.0-oracle-devel':
    ensure   => present,
  }
}
