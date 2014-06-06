#
# = Class: tools::sstp
#
class tools::sstp {

  package { 'sstp-client': ensure => present, }

}
