#
# Class: tools::maatkit
#
# This modules installs maatkit
#
class tools::maatkit {
  package { 'maatkit': ensure  => present, }
}
