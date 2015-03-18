#
# Class: tools::pdftk
#
# This modules installs pdftk
#
class tools::pdftk {
  package { 'pdftk': ensure  => present, }
}
