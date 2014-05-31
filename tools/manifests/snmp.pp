# Class: tools::snmp
#
# This module installs SNMP
#
class tools::snmp {

  case $::osfamily {
    default: {}
    /(RedHat|redhat|amazon)/: {
      package { 'net-snmp':       ensure => present, }
      package { 'net-snmp-utils': ensure => present, }
    }
    /(Debian|debian)/: {
    }
  }

}
