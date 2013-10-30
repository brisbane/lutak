#
# = Class: plymouth::theme::spinfinity
#
# Installs and sets up PlyMouth theme spinfinity
class plymouth::theme::spinfinity {

  package { 'plymouth-theme-spinfinity': ensure => present, }

}
