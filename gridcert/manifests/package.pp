# Class: gridcert::package
#
# This module installs lcg-CA package
#
class gridcert::package {
  package { 'lcg-CA':
    ensure  => latest,
  }
}
