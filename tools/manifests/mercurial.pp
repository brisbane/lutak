# Class: tools::mercurial
#
# This module manages Mercurial (hg) VCDS
#
class tools::mercurial {

  package { 'mercurial': ensure => present, }

}
