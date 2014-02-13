#
# = Class: plymouth::theme::script
#
# Installs and sets up PlyMouth theme script
class plymouth::theme::script {

  package { 'plymouth-theme-script': ensure => present, }

}
