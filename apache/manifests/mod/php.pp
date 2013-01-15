# Class: apache::mod::php
class apache::mod::php {
  include apache::params
  include php
  apache::mod { 'php5': }
  file { "${apache::params::vdir}/php.conf":
    ensure  => present,
    content => template('apache/mod/php.conf.erb'),
  }
}
