# Class: yum::repo::pgdg92
#
# This module manages PostgreSQL 9.2 repo files for $lsbdistrelease
#
class yum::repo::pgdg92 {
  require yum
  class { 'yum::repodef::pgdg92': stage => 'yumsetup' }
}
