#
# = Class: plymouth::theme::fadein
#
# Installs and sets up PlyMouth theme Fade-In
class plymouth::theme::fadein {

  package { 'plymouth-theme-fade-in': ensure => present, }

}
