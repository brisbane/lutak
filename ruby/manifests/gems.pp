# Class: ruby::gems
#
# This modules installs rubygems
#
class ruby::gems {
  package { 'rubygems':
    ensure  => present,
  }
}
