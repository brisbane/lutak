# Class: tools::git
#
# This modules installs git
#
class tools::git {

  package { 'git':     ensure  => latest, }
  package { 'git-svn': ensure  => latest, }

}
