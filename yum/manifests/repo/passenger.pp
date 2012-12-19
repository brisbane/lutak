# Class: yum::repo::passenger
#
# This module manages Passenger repo files for $lsbdistrelease
# https://www.phusionpassenger.com/native_packages
#
class yum::repo::passenger {
  require yum
  class { 'yum::repodef::passenger': stage => 'yumsetup' }
}
