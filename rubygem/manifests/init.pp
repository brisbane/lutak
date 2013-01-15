# Class: rubygem
#
# This modules installs rubygems
#
class rubygem {
  package { 'rubygems':
    ensure  => present,
  }
}
