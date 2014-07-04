#
# = Class: plymouth::theme::rings
#
# Installs and sets up PlyMouth theme rings
class plymouth::theme::rings {

  package { 'plymouth-theme-rings': ensure => present, }

}
