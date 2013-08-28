# Class: java::oracle7::fonts
#
# This module manages java fonts package from srce repo for Java 7
#
class java::oracle7::fonts {
  require yum::repo::srce::intern

  package { 'java-1.7.0-oracle-fonts':
    ensure   => present,
  }
}
