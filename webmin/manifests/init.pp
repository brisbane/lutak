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
}
