# Class: yum::repo::vmware
#
# This module manages vmware repo files for $operatingsystemrelease
#
class yum::repo::vmware (
  $stage = 'yumsetup',
){
  require yum::repo::base

  case $::operatingsystemrelease {
    default : {}
    /^5.*/: {
      file { '/etc/yum.repos.d/vmware-osps.repo':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/vmware-osps.repo",
        require => Package['vmware-tools-repo-RHEL5'],
      }
      package { 'vmware-tools-repo-RHEL5':
        ensure   => '8.6.5-2',
        provider => 'rpm',
        source   => "http://packages.vmware.com/tools/esx/5.0u1/repos/vmware-tools-repo-RHEL5-8.6.5-2.${::architecture}.rpm",
      }
    }
    /^6.*/: {
      file { '/etc/yum.repos.d/vmware-osps.repo':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/vmware-osps.repo",
        require => Package['vmware-tools-repo-RHEL5'],
      }
      package { 'vmware-tools-repo-RHEL6':
        ensure   => '8.6.5-2',
        provider => 'rpm',
        source   => "http://packages.vmware.com/tools/esx/5.0u1/repos/vmware-tools-repo-RHEL6-8.6.5-2.${::architecture}.rpm",
      }
    }
  }
}
