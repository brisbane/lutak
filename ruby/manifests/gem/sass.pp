# Class: ruby::gem::sass
#
# This modules installs sass rubygem
#
class ruby::gem::sass {
  package { 'rubygem-sass':
    ensure  => present,
  }
}
