# Class: jenkins::params
#
# This module contains defaults for jenkins modules
#
class jenkins::params {
  $package_ensure  = 'present'
  $java_version    = 6
}
