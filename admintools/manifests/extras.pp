# Class: admin-tools::extras
#
# This modules installs extra administration utilities
#
class admintools::extras {
  require yum::repo::base
  package { 'etckeeper':
    ensure  => latest,
  }
  package { 'subversion':
    ensure  => latest,
  }
  package { 'git':
    ensure  => latest,
  }
  package { 'git-svn':
    ensure  => latest,
  }
}
