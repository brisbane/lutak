# Class: java-sun
#
# This module manages java-sun package from srce repo
#
class java::sun {
  include yumreposd::srce-intern
  package { 'java-1.6.0-sun':
    ensure   => present,
    require  => Class['yumreposd::srce-intern'],
  }
  package { 'java-1.6.0-sun-devel':
    ensure   => present,
    require  => Class['yumreposd::srce-intern'],
  }
}
