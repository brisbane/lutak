#
# = Class: desktop::rxvt
#
# This module installs rxvt unicode (urxvt)
#
class desktop::rxvt {

  package { 'rxvt':
    ensure => present,
    name   => 'rxvt-unicode'
  }

}
