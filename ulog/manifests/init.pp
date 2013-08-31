# Class: ulog
#
# This modules installs ulog
#
class ulog {
  package { 'ulogd':
    ensure  => installed,
  }
  service { 'ulogd':
    ensure   => running,
    enable   => true,
    provider => 'redhat',
    require  => Package['ulogd'],
  }
}
