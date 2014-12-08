# Class: gridcert::package
#
# This module installs ca-policy-egi-core package
#
class gridcert::package {
  package { 'ca-policy-egi-core':
    ensure  => latest,
  }
}
