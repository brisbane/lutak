# Class: yum::repo::base
#
# This module manages Base repo files for $operatingsystemrelease
#

# CentOS 5.x
class yum::repo::base {
  include yum
  class {'yum::repodef::base': stage => 'yumsetup' }
}
