# Class: ocsinventory::agent
#
# This module manages OCS inventory agent
#
class ocsinventory::agent (
  $package_ensure = 'latest',
  $server = 'localhost',
  $pause = 0,
) inherits zabbix {
  package { 'ocsinventory-agent':
    ensure   => $package_ensure,
  }
  file { '/etc/sysconfig/ocsinventory-agent':
    ensure  => present,
    require => Package['ocsinventory-agent'],
    content => template('ocsinventory/ocsinventory-agent.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
