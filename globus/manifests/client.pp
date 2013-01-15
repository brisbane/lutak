# Class: globus::client
#
# Installs Globus Toolkit client tools
#
class globus::client {
  include gridcert::crl
  $packages = ['globus-proxy-utils', 'uberftp', 'globus-gass-copy-progs', 'globus-gram-client-tools']

  package { $packages:
    ensure => latest,
  }
}
