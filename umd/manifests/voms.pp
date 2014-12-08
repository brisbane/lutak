# Class: umd::voms
#
class umd::voms {
  file { '/etc/grid-security/vomsdir':
      ensure => directory,
      purge  => true,
      owner  => root,
      group  => root,
      mode   => '0755',
  }
}
