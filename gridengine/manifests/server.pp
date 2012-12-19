# Class: gridengine::node
#
# This class installs the SGE master
#
class gridengine::server inherits gridengine {
  package { 'gridengine-qmaster':
    ensure => present,
  }
}
