# Class: gridcert::package
#
# This module installs ca-policy-egi-core package
#
class gridcert::crl {
  include gridcert::package
  package { 'fetch-crl':
    ensure  => latest,
  }
  service { 'fetch-crl-cron':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => [ Package['fetch-crl'], Package['ca-policy-egi-core'] ],
  }
}
