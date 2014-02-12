#
# = Class: desktop::de::xfce4::remmina
#
# Installs XFCE 4 remmina plugin
class desktop::de::xfce4::remmina {

  package { 'xfce4-remmina-plugin': ensure => present, }

}
