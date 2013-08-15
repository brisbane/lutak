# Class: yum::repo::russian
#
# This module manages russian repo files for $operatingsystemrelease
#
class yum::repo::russian (
  $stage    = 'yumsetup',
  $priority = '99',
  $exclude  = [],
){
  require yum::repo::base

  file { '/etc/yum.repos.d/russianfedora-free.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template("yum/${::operatingsystem}/${::operatingsystemrelease}/russianfedora-free.erb"),
    require => Package['russian-release'],
  }

  case $::operatingsystemrelease {
    default: {}
    /^6.*/: {
      package { 'russian-release' :
        ensure   => '6-3.R',
        provider => 'rpm',
        source   => 'http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/el/releases/6/Everything/x86_64/os/russianfedora-free-release-6-3.R.noarch.rpm',
      }
    }
  }
}
