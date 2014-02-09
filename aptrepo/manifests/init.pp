# Class: aptrepo
#
# This module manages aptrepo packages
#
class aptrepo {
  # declare running stages
  stage {'aptsetup': before => Stage['main'] }
}
