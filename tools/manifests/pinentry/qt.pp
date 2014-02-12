#
# = Class: tools::pinentry::qt
#
class tools::pinentry::qt {

  include ::tools::pinentry
  package { 'pinentry-qt': ensure => present, }

}
