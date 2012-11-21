# Class: gitosis
#
# Module for managing gitosis (git repo)
#
class gitosis {
  package { 'gitosis':
    ensure => present,
  }
}
