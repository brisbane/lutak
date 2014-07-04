#
# = Class: tools::powertop
#
# Install VNstat - network statistics tool
#
class tools::powertop {

  package { 'powertop': ensure => present, }

}
