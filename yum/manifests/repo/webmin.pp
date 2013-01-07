# Class: yum::repo::webmin
#
# This module manages Webmin repo files for $lsbdistrelease
#
class yum::repo::webmin {
  require yum
  class { 'yum::repodef::webmin': stage => 'yumsetup' }
}
