# Class: rhcs
#
# This module deploys base RedHah Cluster Suite packages
#
class rhcs (
  $config_file = 'puppet:///modules/rhcs/cluster.conf',
  $ricci_passwd = 'test',
) {
  package { 'cman':
    ensure => present,
  }
  package { 'rgmanager':
    ensure => present,
  }
  package { 'ricci':
    ensure => present,
  }
  package { 'ccs':
    ensure => present,
  }
  service { 'cman':
    enable    => true,
    provider  => redhat,
    require   => Package['cman']
  }
  service { 'rgmanager':
    enable    => true,
    provider  => redhat,
    require   => [ Package['rgmanager'], Service['cman'] ],
  }
  exec { 'setriccipasswd':
    user    => 'root',
    group   => 'root',
    command => "echo \"$ricci_passwd\" | passwd --stdin ricci",
    onlyif  => 'grep ricci:\!\!: /etc/shadow > /dev/null',
    require => Package['ricci'],
  }
  service { 'ricci':
    ensure    => running,
    enable    => true,
    provider  => redhat,
    require   => Package['ricci'],
  }
}
