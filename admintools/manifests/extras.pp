# Class: admintools::extras
#
# This modules installs extra administration utilities
#
class admintools::extras {
  package { 'etckeeper':
    ensure  => present,
  }
  package { 'subversion':
    ensure  => present,
  }
  package { 'git':
    ensure  => present,
  }
  package { 'git-svn':
    ensure  => present,
  }
}
