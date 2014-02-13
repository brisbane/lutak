#
# = Class: tools::dcfldd
#
# This modules installs dcfldd
#
class tools::dcfldd {

  package { 'dcfldd':
    ensure  => present,
  }

}
