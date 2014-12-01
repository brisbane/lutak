# Class: yum::repo::base
#
# This module manages Base repo files for $operatingsystemrelease
#

# CentOS
class yum::repo::base (
  $stage     = 'yumsetup',
  $priority  = '1',
  $exclude   = [],
  $include   = [],
  $debuginfo = false,
){

  case $::operatingsystem {
    # Amazon AMI Linux (RedHat derivative)
    'Amazon' : {
      include ::yum::repo::base::amazon
    }
    # CentOS (Community Enterprise Operating System)
    'CentOS' : {
      file { '/etc/yum.repos.d/CentOS-Base.repo':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/CentOS-Base.erb"),
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
    'Fedora': {
      file { '/etc/yum.repos.d/fedora.repo':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/fedora.erb"),
        require => Package['fedora-release'],
      }
      file { '/etc/yum.repos.d/fedora-updates.repo':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/fedora-updates.erb"),
        require => Package['fedora-release'],
      }
      case $::operatingsystemrelease {
        default: {
          $nameaddon = '-plugin'
        }
        /^18.*/: {
          $nameaddon = '-plugin'
          package { 'fedora-release':
            ensure   => present,
            provider => rpm,
            source   => 'http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/fedora/linux/releases/18/Fedora/x86_64/os/Packages/f/fedora-release-18-1.noarch.rpm',
          }
          package { 'fedora-release-notes':
            ensure   => present,
            provider => rpm,
            source   => 'http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/fedora/linux/releases/18/Fedora/x86_64/os/Packages/f/fedora-release-notes-18.0.0-3.fc18.noarch.rpm',
          }
        }
      }
      # yum helpers
      package { 'yum-utils': }
      package { "yum${nameaddon}-changelog": }
      package { "yum${nameaddon}-merge-conf": }
      package { "yum${nameaddon}-priorities": }
      package { "yum${nameaddon}-protectbase": }
      package { "yum${nameaddon}-upgrade-helper": }
      package { "yum${nameaddon}-versionlock": }
    }
  }
}
