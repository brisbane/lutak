# Class: yum::repo::elasticsearch
#
# This module manages elasticsearch repo files for $operatingsystemrelease
#
class yum::repo::elasticsearch (
  $stage     = 'yumsetup',
  $priority  = '99',
  $exclude   = [],
  $include   = [],
  $debuginfo = false,
  $version  = '0.90',
){
  require yum::repo::base

  file { '/etc/yum.repos.d/elasticsearch.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/elasticsearch.erb"),
  }

}
