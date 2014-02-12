# = Class: desktop::chromium
#
# This module installs chromium
#
class desktop::chromium {

  package { 'chromium': ensure => present, }

}
