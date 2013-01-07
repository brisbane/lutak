# Class: yum::repodef::wandisco
#
# This module manages Wandisco repo files for $lsbdistrelease
# Repo serves SVN 1.7
#
class yum::repodef::wandisco {
  include yum::repo::base

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/yum/keys/RPM-GPG-KEY-WANdisco',
  }
  file { '/etc/yum.repos.d/wandisco.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/wandisco.repo",
    require => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco'],
  }
}
