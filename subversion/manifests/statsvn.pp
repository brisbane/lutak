#
# = Class: subversion::statsvn
#
# This modules installs statsvn
#
class subversion::statsvn {
  include ::subversion

  package { 'statsvn': ensure => present, }

}
