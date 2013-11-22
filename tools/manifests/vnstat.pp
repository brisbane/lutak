#
# = Class: tools::vnstat
#
# Install VnStat - network statistics tool
#
class tools::vnstat {

  package { 'vnstat': ensure => present, }

}
