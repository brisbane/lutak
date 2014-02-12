#
# = Class: desktop::de::xfce4::verve
#
# Installs XFCE 4 verve plugin
class desktop::de::xfce4::verve {

  package { 'xfce4-verve-plugin': ensure => present, }

}
