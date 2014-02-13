# Class: ruby::gem::compass
#
# This modules installs compass rubygem
#
class ruby::gem::compass {
  package { 'rubygem-compass':
    ensure  => present,
  }
}
