# Class: rubygem::mysql
#
# This modules installs mysql rubygem
#
class rubygem::mysql {
  package { 'rubygem-mysql':
    ensure  => present,
  }
}
