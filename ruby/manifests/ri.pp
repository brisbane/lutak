#
# = Class: ruby::ri
#
# This modules installs ruby's ri
#
class ruby::ri {
  package { 'ruby-ri':
    ensure  => present,
  }
}
