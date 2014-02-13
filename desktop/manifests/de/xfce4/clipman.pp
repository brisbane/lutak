#
# = Class: desktop::de::xfce4::clipman
#
# Installs XFCE 4 clipman plugin
class desktop::de::xfce4::clipman {

  package { 'xfce4-clipman-plugin': ensure => present, }

}
