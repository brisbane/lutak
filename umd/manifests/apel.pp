# Class: umd::apel
#
# This modules installs UMD APEL3
#
class umd::apel (
  $dbname    = 'apelclient',
  $dbuser    = 'apel',
  $dbpass    = 'set_in_hiera',
  $cehost    = '',
  $sitename  = 'GOCDB_SITENAME',
  $hour      = '6',
  $minute    = '0',
  $summaries = true,
  $dest      = '',
) {
  require ::gridcert
  require ::gridcert::crl

  package { ['apel-ssm', 'apel-lib', 'apel-client']:
    ensure  => present,
  }
  include ::mysql::client
  include ::mysql::server
  ::mysql::db { $dbname:
    user     => $dbuser,
    password => $dbpass,
    host     => 'localhost',
    grant    => ['all'],
    sql      => '/usr/share/apel/client.sql',
    require  => Package['apel-client'],
  }


  file { '/etc/apel/client.cfg':
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('umd/client.cfg.erb'),
    require => Package['apel-client'],
  }
  file { '/etc/apel/sender.cfg':
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('umd/sender.cfg.erb'),
    require => Package['apel-client'],
  }

  cron { 'glite_apel':
    command => '/usr/bin/apelclient',
    user    => 'root',
    hour    => $hour,
    minute  => $minute,
  }
}
