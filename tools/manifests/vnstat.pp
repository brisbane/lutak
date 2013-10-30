#
# = Class: tools::vnstat
#
# Install VNstat - network statistics tool
#
class tools::vnstat {

  package { 'vnstat': ensure => present, }

}
