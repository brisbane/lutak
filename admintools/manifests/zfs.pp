#
# = Class: admintools::zfs
#
# This class installs ZFSonLinux
#
class admintools::zfs {

  require ::yum::repo::zfs

  package { 'zfs': ensure => present, }

}
