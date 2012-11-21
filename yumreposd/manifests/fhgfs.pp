# Class: yumreposd::fhgfs
#
# This module manages FhGFS repo files for $lsbdistrelease
#
class yumreposd::fhgfs {
  file { '/etc/yum.repos.d/fhgfs.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/fhgfs.repo",
  }
}
