# Class: admintools::tmux
#
# This module manages TMux
#
class admintools::tmux {

  package { 'tmux': ensure => present, }

}
