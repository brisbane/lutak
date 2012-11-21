# Class: yumreposd::wandisco
#
# This module manages Wandisco repo files for $lsbdistrelease
# Repo serves SVN 1.7
#
class yumreposd::wandisco {
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/yumreposd/keys/RPM-GPG-KEY-WANdisco',
  }
  file { '/etc/yum.repos.d/wandisco.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  =>  "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/wandisco.repo",
    require => [ File['/etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco'], ],
  }
}
