# Class: pyqt4
#
# This module manages PyQt4 toolkit
#
class pyqt4 {
  package { 'PyQt4':
    ensure   => present,
  }
  package { 'PyQt4-webkit':
    ensure   => present,
  }
  package { 'xorg-x11-server-Xvfb':
    ensure   => present,
  }
  package { 'xorg-x11-xauth':
    ensure   => present,
  }
  package { 'xorg-x11-fonts-Type1':
    ensure   => present,
  }
}
