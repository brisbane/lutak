# Class: admintools::compression
#
# This modules installs extra compression utilities
#
class admintools::compression {
  package { 'xdelta': ensure => present, }
  # parallel compressors
  package { 'pbzip2': ensure => present, }
  package { 'pigz':   ensure => present, }
}
