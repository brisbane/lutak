#
# = Class: tools::zfs
#
# This class installs ZFSonLinux
#
class tools::zfs {

  include ::yum::repo::zfs
  package { 'zfs': ensure => present, }

}
