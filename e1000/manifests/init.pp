# Class: e1000
#
# This modules installs e1000 driver:
#  http://blog.bradiceanu.net/2010/11/28/netdev-watchdog-eth0-transmit-timed-out/
#
class e1000 {
  package { 'e1000':
    ensure  => present,
  }

  file { '/etc/modprobe.d/e1000.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/e1000/e1000.conf',
    require => Package['e1000'],
  }
}
