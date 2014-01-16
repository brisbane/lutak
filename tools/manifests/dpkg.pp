#
# = Class: tools::dpkg
#
class tools::dpkg {

  package { 'dpkg': ensure => present, }

}
