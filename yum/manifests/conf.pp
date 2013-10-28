# Class: yum::conf
#
# This module manages yum packages
#
class yum::conf (
  $stage     = 'yumconf',
  $yum_proxy = 'UNDEF',
) {
  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {}
    /^6.*/: {
      file { '/etc/yum.conf' :
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template('yum/el6.yum.conf.erb'),
      }
    }
  }
}
