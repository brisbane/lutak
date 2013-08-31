# Class: private::rootkeys
class private::rootkeys {
  File {
    ensure => file,
    owner  => root,
    group  => root,
  }
  file { '/root/.ssh':
    ensure => directory,
    mode   => '0700',
  }
  file { '/root/.ssh/id_rsa':
    mode   => '0600',
    source => 'puppet:///private/rootkeys/id_rsa',
  }
  file { '/root/.ssh/id_rsa.pub':
    mode   => '0644',
    source => 'puppet:///private/rootkeys/id_rsa.pub',
  }

}
