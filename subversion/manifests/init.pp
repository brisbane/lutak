#
# = Class: subversion
#
# This modules installs and manages subversion
#
class subversion {

  package { 'subversion':
    ensure => installed,
  }

}
