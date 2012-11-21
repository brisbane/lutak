# Class: yumreposd::pgdg92
#
# This module manages PostgreSQL 9.2 repo files for $lsbdistrelease
#
class yumreposd::pgdg92 {
  file { '/etc/yum.repos.d/pgdg-92-centos.repo' :
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    source  => "puppet:///modules/yumreposd/${::operatingsystem}/${::operatingsystemrelease}/pgdg-92-centos.repo",
    require => [ Package['puppetlabs-release'], Class['yumreposd::base'] ],
  }

  # install package depending on major version
  case $::operatingsystemrelease {
    default: {}
    /^5.*/: {
      package { 'pgdg-centos92' :
        ensure   => '9.2-6',
        provider => 'rpm',
        source   => 'http://yum.postgresql.org/9.2/redhat/rhel-5-i386/pgdg-centos92-9.2-6.noarch.rpm', }
    }
    /^6.*/: {
      package { 'pgdg-centos92' :
        ensure   => '9.2-6',
        provider => 'rpm',
        source   => 'http://yum.postgresql.org/9.2/redhat/rhel-6-i386/pgdg-centos92-9.2-6.noarch.rpm', }
    }
  }
}
