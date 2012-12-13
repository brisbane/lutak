# Class: yumreposd::puppetlabls
#
# This module manages PuppetLabs repo files for $lsbdistrelease
#
class yumreposd::gluster {
  file { '/etc/yum.repos.d/gluster.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/gluster.repo",
    require => [ Class['yumreposd::base'] ],
  }

}
