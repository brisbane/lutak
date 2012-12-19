# Class: yum::repodef::base
#
# This module manages Base repo files for $operatingsystemrelease
#
class yum::repodef::base {
  # base package
  package {'yum': ensure => present }

  # directory for repositories
  file {'/etc/yum.repos.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    recurse => true,
    purge   => true,
    force   => true,
    require => Package['yum'],
  }

  case $::operatingsystem {
    'CentOS' : {
      file { '/etc/yum.repos.d/CentOS-Base.repo':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/CentOS-Base.repo",
        require => Package['centos-release'],
      }
      case $::operatingsystemrelease {
        default: {
          $nameaddon = ''
        }
        /^5.*/: {
          $nameaddon = ''
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
          $nameaddon = '-plugin'
          package { 'centos-release':
            ensure   => present,
            provider => rpm,
            source   => 'http://mirror.centos.org/centos-6/6.3/os/x86_64/CentOS/Packages/centos-release-6-3.el6.centos.9.x86_64.rpm',
          }
        }
      }
      # yum helpers
      package { 'yum-utils': }
      package { "yum${nameaddon}-changelog": }
      package { "yum${nameaddon}-downloadonly": }
      package { "yum${nameaddon}-merge-conf": }
      package { "yum${nameaddon}-priorities": }
      package { "yum${nameaddon}-protectbase": }
      package { "yum${nameaddon}-upgrade-helper": }
      package { "yum${nameaddon}-versionlock": }
    }
  }
}
