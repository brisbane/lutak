# Class: ruby::gem::mysql
#
# This modules installs mysql rubygem
#
class ruby::gem::mysql {
  package { 'rubygem-mysql':
    ensure  => present,
  }
}
