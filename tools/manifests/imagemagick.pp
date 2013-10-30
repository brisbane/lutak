# Class: tools::imagemagick
#
# This module installs ImageMagick
#
class tools::imagemagick {
  package { 'ImageMagick': ensure => present, }
}
