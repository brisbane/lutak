# Class: yum::repo::ius::testing
#
# This module adds IUS testing repo to $lsbdistrelease
#
class yum::repo::ius::testing (
  $stage     = 'yumsetup',
  $priority  = '62',
  $exclude   = [],
  $include   = [],
  $debuginfo = false,
){
  require yum::repo::ius

  file {  '/etc/yum.repos.d/ius-testing.repo':
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/ius-testing.erb"),
  }
}
