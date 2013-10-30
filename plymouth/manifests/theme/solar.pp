#
# = Class: plymouth::theme::solar
#
# Installs and sets up PlyMouth theme solar
class plymouth::theme::solar {

  package { 'plymouth-theme-solar': ensure => present, }

}
