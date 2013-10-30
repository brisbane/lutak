#
# = Class: tools::vim::puppet
#
class tools::vim::puppet {

  include ::tools::vim
  package { 'vim-puppet': ensure => present, }

}
