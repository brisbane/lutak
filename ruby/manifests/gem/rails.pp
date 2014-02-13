# Class: ruby::gem::rails
#
# This modules installs ruby on rails
#
class ruby::gem::rails {
  package { 'rubygem-rails':
    ensure  => present,
  }
}
