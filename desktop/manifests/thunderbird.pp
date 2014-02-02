# = Class: desktop::thunderbird
#
# This module installs Thunderbird
#
class desktop::thunderbird {

  package { 'thunderbird': ensure => present, }

}
