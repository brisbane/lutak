# Class: admintools::buildchain
#
# This module manages build utils
#
class admintools::buildchain {

  package { 'make':    ensure => present, }
  package { 'gcc':     ensure => present, }
  package { 'gcc-c++': ensure => present, }
  package { 'kernel-headers': ensure => present, }
  package { 'kernel-devel':   ensure => present, }

}
