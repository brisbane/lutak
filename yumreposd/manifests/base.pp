# Class: yumreposd::base
#
# This module manages Base repo files for $operatingsystemrelease
#

# CentOS 5.x
class yumreposd::base inherits yumreposd {
  case $::operatingsystem {
    'CentOS' : {
      file { '/etc/yum.repos.d/CentOS-Base.repo':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/CentOS-Base.repo",
        require => Package['centos-release'],
      }
      file { '/etc/yum.repos.d/CentOS-Debuginfo.repo':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/CentOS-Debuginfo.repo",
        require => Package['centos-release'],
      }
      file { '/etc/yum.repos.d/CentOS-Media.repo' :
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/CentOS-Media.repo",
        require => Package['centos-release'],
      }
      # branch specifics
      case $::operatingsystemrelease {
        default: {}
        /^5.*/: {
          file { '/etc/yum.repos.d/CentOS-Vault.repo' :
            ensure  => file,
            mode    => '0644',
            owner   => root,
            group   => root,
            source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/CentOS-Vault.repo",
            require => Package['centos-release'],
          }
          package { 'centos-release':
            ensure   => present,
            provider => rpm,
            source   => 'http://mirror.centos.org/centos-5/5.8/os/x86_64/CentOS/centos-release-5-8.el5.centos.x86_64.rpm',
          }
          package { 'centos-release-notes':
            ensure   => present,
            provider => rpm,
            source   => 'http://mirror.centos.org/centos/5.8/os/x86_64/CentOS/centos-release-notes-5.8-0.x86_64.rpm',
          }
        }
        /^6.*/: {
          package { 'centos-release':
            ensure   => present,
            provider => rpm,
            source   => 'http://mirror.centos.org/centos-6/6.3/os/x86_64/CentOS/Packages/centos-release-6-3.el6.centos.9.x86_64.rpm',
          }
        }
      }
    }
  }
}
