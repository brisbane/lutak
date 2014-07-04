# Class: private::hosts
class private::hosts {
  file { '/etc/hosts':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///private/hosts',
  }
}
