# Class: yum::repo::mongodb
#
# This module manages MongoDB repo files for $lsbdistrelease
#
class yum::repo::mongodb (
  $stage     = 'yumsetup',
  $priority  = '1',
  $exclude   = [],
  $include   = [],
  $debuginfo = false,
){
  require ::yum::repo::base

  file { '/etc/yum.repos.d/mongodb.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/mongodb.erb"),
  }

}
