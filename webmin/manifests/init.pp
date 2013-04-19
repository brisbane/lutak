# Class: webmin
#
# This module manages Webmin
#
class webmin (
  $libwrap       = '0',
  $alwaysresolve = '1',
  $allow         = [ '0.0.0.0/0' ],
) {
  require yum::repo::webmin
  require perl::mod::net::ssleay
  require perl::mod::authen::pam

  package { 'webmin': ensure => present, }

  file { '/etc/webmin/miniserv.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('webmin/miniserv.conf.erb'),
    require => Package['webmin'],
  }

  service { 'webmin':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/webmin/miniserv.conf'],
  }


  # webmin.acl
  concat { '/etc/webmin/webmin.acl':
    owner   => root,
    group   => root,
    mode    => '0600',
    notify  => Service['webmin'],
  }
  concat::fragment { 'webmin_acl:header':
    target  => '/etc/webmin/webmin.acl',
    source  => 'puppet:///modules/webmin/webmin.acl',
    order   => '100',
  }

  # miniserv.users
  concat { '/etc/webmin/miniserv.users':
    owner   => root,
    group   => root,
    mode    => '0600',
    notify  => Service['webmin'],
  }
  concat::fragment { 'miniserv_users:header':
    target  => '/etc/webmin/miniserv.users',
    source  => 'puppet:///modules/webmin/miniserv.users',
    order   => '100',
  }



}
