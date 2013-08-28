# Class: jenkins::params
#
# This module contains defaults for jenkins modules
#
class jenkins::params {
  $package_ensure  = 'present'
  $java_vendor     = 'oracle'
  $java_version    = '7'
}
