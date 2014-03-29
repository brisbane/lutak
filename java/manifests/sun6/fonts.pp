# Class: java::sun6::fonts
#
# This module manages java fonts package from srce repo for Java 6
#
class java::sun6::fonts {
  require yum::repo::srce::intern

  package { 'java-1.6.0-sun-fonts':
    ensure   => present,
  }
}
