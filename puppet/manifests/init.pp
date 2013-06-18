# Class: puppet
#
# This module manages puppet and is standard for all hosts
#
# Requires:
#   $puppetmaster must be set in
#

# Sample Usage:
#   include puppet
#
class puppet (
  $package_ensure = $puppet::params::package_ensure,
  $puppetmaster   = $puppet::params::puppetmaster,
  $agentenv       = $puppet::params::agentenv,
) inherits puppet::params {
  # file defaults
  File {
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['puppet'],
  }

  # package and service
  package { 'puppet':
    ensure  => $package_ensure,
  }
  case $::operatingsystem {
    default : {
      service { 'puppet':
        ensure   => 'running',
        enable   => true,
        provider => 'redhat',
        require  => File['/etc/puppet/puppet.conf'],
      }
    }
    'CentOS' : {
      service { 'puppet':
        ensure   => 'running',
        enable   => true,
        provider => 'redhat',
        require  => File['/etc/puppet/puppet.conf'],
      }
    }
    'Fedora' : {
      service { 'puppetagent':
        ensure   => 'running',
        enable   => true,
        provider => 'redhat',
        require  => File['/etc/puppet/puppet.conf'],
      }
    }
  }
  # files
  file { '/etc/puppet/puppet.conf': content => template('puppet/puppet.conf.erb'), }
  file { '/etc/puppet/auth.conf':   source  => 'puppet:///modules/puppet/auth.conf', }
  file { '/etc/sysconfig/puppet':   content => template('puppet/sysconfigpuppet.erb'), }
}
