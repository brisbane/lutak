# Class: admin-tools::extras
#
# This modules installs extra administration utilities
#
class admin-tools::extras {
  #package { 'ulogd': ensure => latest, }
  package { 'etckeeper':
    ensure  => latest,
    require => Class['yumreposd::srce'],
  }
  package { 'subversion':
    ensure  => latest,
    require => Class['yumreposd::epel'],
  }
  package { 'git':
    ensure  => latest,
    require => Class['yumreposd::base'],
  }
}
