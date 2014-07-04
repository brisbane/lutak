#
# = Class: tools::vim
#
class tools::vim {

  package { 'vim-enhanced': ensure => present, }

}
