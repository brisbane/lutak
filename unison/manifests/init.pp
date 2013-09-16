#
# = Class: unison
#
# This class manages unison package
#
class unison {
  package { 'unison':
    ensure  => present,
  }
}
# vi:nowrap
