# Class: admintools::imagemagick
#
# This module manages imagemagick
#
class admintools::imagemagick {
  package { 'ImageMagick': ensure => present, }
}
