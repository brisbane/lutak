# Class: mysql::server
#
# This module manages mysql-sevrer files
#
class mysql::server inherits mysql {
  include mysql
  package { 'mysql-server':
    ensure => present,
  }
  package { 'mysqltuner':
    ensure  => present,
    require => Package['mysql-server'],
  }
  service { 'mysqld':
    ensure  => running,
    enable  => true,
    require => Package['mysql-server'],
  }
}
