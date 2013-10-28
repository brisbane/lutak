# Class: gridcert::package
#
# This module installs lcg-CA package
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
    require  => [ Package['fetch-crl'], Package['lcg-CA'] ],
  }  
}
