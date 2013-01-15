# Class: rubygem::sqlite3ruby
#
# This modules installs sqlite3ruby on rails
#
class rubygem::sqlite3ruby {
  package { 'rubygem-sqlite3-ruby':
    ensure  => present,
  }
}
