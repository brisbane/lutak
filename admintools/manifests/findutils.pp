# Class: admintools::findutils
#
# This modules installs extra administration utilities
#
class admintools::findutils {
  case $::osfamily {
    default: { }
    /(Debian|debian|Ubuntu|ubuntu)/: {
      package { 'locate': ensure  => present, }
    }
    /(RedHat|redhat|amazon)/: {
      package { 'mlocate': ensure  => present, }
    }
  }
}
