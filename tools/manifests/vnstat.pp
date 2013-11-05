#
# = Class: tools::vnstat
#
# Install PowerTop - power consumption utility
#
class tools::vnstat {

  package { 'vnstat': ensure => present, }

}
