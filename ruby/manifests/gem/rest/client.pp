# Class: ruby::gem::rest::client
#
# This modules installs rest-client rubygem
#
class ruby::gem::rest::client {
  package { 'rubygem-rest-client':
    ensure  => present,
  }
}
