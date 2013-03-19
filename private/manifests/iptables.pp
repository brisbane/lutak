# Class: private::iptables
class private::iptables {
  file { '/etc/sysconfig/iptables':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0600',
    source => 'puppet:///private/iptables',
  }
  service { 'iptables':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/sysconfig/iptables'],
  }
}
