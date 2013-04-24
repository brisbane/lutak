# Class: tsm::params
#
# This module contains defaults for tsm modules
#
class tsm::params {
  $package_ensure  = 'present'
  $backup_service  = 'running'
  $archive_service = 'running'
}
