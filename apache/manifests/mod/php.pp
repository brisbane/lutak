# Class: apache::mod::php
class apache::mod::php {
  include apache::params
  require ::php

  apache::mod { 'php5': }
  file { "${apache::params::vdir}/php.conf":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('apache/mod/php.conf.erb'),
    notify  => Service['httpd'],
  }
}
