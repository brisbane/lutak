# Class: rubygem::rails
#
# This modules installs ruby on rails
#
class rubygem::rails {
  package { 'rubygem-rails':
    ensure  => present,
  }
}
