# Class: tools::ntfs3g
#
# This module installs NTFS 3g driver
#
class tools::ntfs3g {
  package { 'ntfs-3g': ensure => present, }
}
