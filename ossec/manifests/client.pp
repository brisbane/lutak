# Class: ossec::client
#
# This module manages ossec client
#
# Requires:
#
#

# Sample Usage:
#   include ossec::ossec
#
class ossec::client inherits ossec {
  package { 'ossec-hids-client':
    ensure   => present,
  }
  service { 'ossec-hids':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => Package['ossec-hids-client'],
  }
  file { '/var/ossec/etc/ossec-agent.conf':
    ensure  => present,
    content => template('ossec/ossec-agent.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['ossec-hids-client'],
    notify  => Service['ossec-hids'],
  }
  file { '/var/ossec/etc/client.keys':
    ensure  => present,
    content => template('ossec/client_keys.erb'),
    owner   => 'ossec',
    group   => 'ossec',
    mode    => '0400',
    require => Package['ossec-hids-client'],
    notify  => Service['ossec-hids'],
  }
}
