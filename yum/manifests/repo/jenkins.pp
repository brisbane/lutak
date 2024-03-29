# Class: yum::repo::jenkins
#
# This module manages Jenkins repo files for $lsbdistrelease
#
class yum::repo::jenkins (
  $stage   = 'yumsetup',
  $exclude   = [],
  $include   = [],
  $debuginfo = false,
){
  require yum::repo::base

  exec { 'jenkins_key':
    command => '/bin/rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key',
    unless  => '/bin/rpm -qa | /bin/grep -i D50582E6 > /dev/null',
  }
  file { '/etc/yum.repos.d/jenkins.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yum/${::operatingsystem}/${::operatingsystemrelease}/jenkins.repo",
    require => Exec['jenkins_key'],
  }
}
