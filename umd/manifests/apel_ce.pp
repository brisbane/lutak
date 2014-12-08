# Class: umd::apel_ce
#
# This modules installs UMD APEL3
#
class umd::apel_ce (
  $dbname    = 'apelclient',
  $dbuser    = 'apel',
  $dbpass    = 'set_in_hiera',
  $sitename  = 'GOCDB_SITENAME',
  $hour      = '3',
  $minute    = '0',
  $type      = '',
  $accBatchDir = '',
) {
  require ::gridcert
  require ::gridcert::crl

  package { ['apel-parsers', 'apel-lib']:
    ensure  => present,
  }

  file { '/etc/apel/parser.cfg':
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('umd/parser.cfg.erb'),
    require => Package['apel-parsers'],
  }
  
  cron { 'glite_apel_parser':
    command => '/usr/bin/apelparser',
    user    => 'root',
    hour    => $hour,
    minute  => $minute,
  }


}
