# Class: admintools::mercurial
#
# This module manages Mercurial (hg) VCDS
#
class admintools::mercurial {

  package { 'mercurial': ensure => present, }

}
