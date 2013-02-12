# Class: admintools::compression
#
# This modules installs extra compression utilities
#
class admintools::compression {
  package { 'xdelta': ensure => latest, }
  # parallel compressors
  package { 'pbzip2': ensure => latest, }
  package { 'pigz':   ensure => latest, }
}
