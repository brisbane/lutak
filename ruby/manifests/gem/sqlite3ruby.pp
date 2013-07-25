# Class: ruby::gem::sqlite3ruby
#
# This modules installs sqlite3ruby on rails
#
class ruby::gem::sqlite3ruby {
  package { 'rubygem-sqlite3-ruby':
    ensure  => present,
  }
}
