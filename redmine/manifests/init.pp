# Class: redmine
#
# This modules installs redmine 2.0
#
class redmine (
  $version    = 'present',
  $db_adapter = 'postgresql',
  $db_name    = 'redmine',
  $db_host    = 'localhost',
  $db_user    = 'root',
  $db_pass    = '',
  $db_enc     = 'utf8',
  $db_schema  = 'public',
) {
  require rubygem
  require rubygem::rails
  require yum::repo::passenger

  # choose correct package
  case $db_adapter {
    postgresql: { $db_package = 'pg' }
    mysql:      { $db_package = 'mysql' }
    mysql2:     { $db_package = 'mysql' }
    sqlite:     { $db_package = 'sqlite' }
    sqlserver:  { fail('SQLserver not supported as RedMine backend yet') }
    default:    { fail('Unrecognized database backend for RedMine') }
  }

  package { 'redmine-db':
    ensure => $version,
    name   => "redmine-${db_package}",
  }

  package { 'redmine':
    ensure  => $version,
    require => Package['redmine-db'],
  }

  file { '/etc/redmine/database.yml':
    ensure  => present,
    owner   => root,
    group   => apache,
    mode    => '0640',
    content => template('redmine/database.yml.erb'),
    require => Package['redmine'],
  }

  file { '/var/www/redmine/public':
    ensure  => link,
    target  => '/usr/share/redmine/public',
    require => Package['redmine'],
  }

  exec { 'redmine_generate_secret_token':
    command => 'rake generate_secret_token',
    cwd     => '/var/www/redmine',
    creates => '/etc/redmine/initializers/secret_token.rb',
    require => File['/var/www/redmine/public'],
  }

#   file { '/var/www/redmine/config/email.yml':
#     ensure  => present,
#     mode    => '0644',
#     content => template('redmine/email-gmailtls.yml.erb'),
#     require => File['/var/www/redmine'],
#   }
#   # plugin folder
#   file { '/var/www/redmine/plugins':
#     ensure => directory,
#     mode   => '0755',
#   }
#   # add /redmine alias to Apache
#   file { '/etc/httpd/conf.d/redmine.conf':
#     ensure  => present,
#     mode    => '0644',
#     owner   => 'root',
#     group   => 'root',
#     source  => 'puppet:///modules/redmine/redmine.conf',
#     require => [ File['/var/www/redmine'], Package['mod_passenger'], ],
#     notify  => Service['httpd'],
#   }
}
