# Class: admintools::scripts::locking
class admintools::scripts::locking {
  file { '/usr/local/bin/locking':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/admintools/scripts/locking',
  }
}
