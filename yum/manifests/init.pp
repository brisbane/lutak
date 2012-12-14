# Class: yum
#
# This module manages yum packages
#
class yum {
  # declare running stage
  stage {'yumsetup': before => Stage['main'] }
}
