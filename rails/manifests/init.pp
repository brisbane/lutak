# Class: rails
#
# This modules installs ruby on rails
#
class rails {
  package { 'rubygem-rails':
    ensure  => present,
  }
}
