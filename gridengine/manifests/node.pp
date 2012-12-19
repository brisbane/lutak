# Class: gridengine::node
#
# This class installs the SGE node
#
class gridengine::node inherits gridengine {
  package { 'gridengine-execd':
    ensure => present,
  }
}
