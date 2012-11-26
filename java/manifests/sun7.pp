# Class: java::sun6
#
# This module manages java-sun package from srce repo for Java 6
#
class java::sun7 {
  include yumreposd::srce_intern
  package { 'java-1.7.0-sun':
    ensure   => present,
    require  => Class['yumreposd::srce_intern'],
  }
  package { 'java-1.7.0-sun-devel':
    ensure   => present,
    require  => Class['yumreposd::srce_intern'],
  }
}
