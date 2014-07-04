# Class: java::oracle7::plugin
#
# This module manages java plugin package from srce repo for Java 7
#
class java::oracle7::plugin {
  require yum::repo::srce::intern

  package { 'java-1.7.0-oracle-plugin':
    ensure   => present,
  }
}
