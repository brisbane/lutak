#
# = Class: desktop::de::xfce4
#
# Installs XFCE 4 desktop environment
class desktop::de::xfce4 {

  # brings Xfce desktop entry to DM
  package { 'xfce-utils':            ensure => present, }

  # XFCE4 stuff
  package { 'xfce4-appfinder':       ensure => present, }
  package { 'xfce4-doc':             ensure => present, }
  package { 'xfce4-icon-theme':      ensure => present, }
  package { 'xfce4-mixer':           ensure => present, }
  package { 'xfce4-panel':           ensure => present, }
  package { 'xfce4-power-manager':   ensure => present, }
  package { 'xfce4-session':         ensure => present, }
  package { 'xfce4-session-engines': ensure => present, }
  package { 'xfce4-settings':        ensure => present, }

  # gtk engine
  package { 'gtk-xfce-engine':       ensure => present, }

}
