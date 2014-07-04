# Class: java::sun7::plugin
#
# This module manages java plugin package from srce repo for Java 7
#
class java::sun7::plugin {
  require yum::repo::srce::intern

  package { 'java-1.7.0-sun-plugin':
    ensure   => present,
  }
}
