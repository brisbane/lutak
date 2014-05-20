#
# Class: tools::teampass
#
# This modules installs TeamPass
#
class tools::teampass {
  package { 'teampass': ensure  => present, }
}
