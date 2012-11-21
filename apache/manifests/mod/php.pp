class apache::mod::php {
  include php
  apache::mod { 'php5': }
  file { "${apache::params::vdir}/php.conf":
    ensure  => present,
    content => template('apache/mod/php.conf.erb'),
  }
}
