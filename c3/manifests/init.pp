# Class: c3
#
# This module manages C3 powertools
#
class c3 {
  package { 'c3':
    ensure   => present,
    provider => 'rpm',
    source   => 'http://www.csm.ornl.gov/torc/C3/Software/5.1.2/rpm/c3-5.1.2-1.noarch.rpm',
  }
}
