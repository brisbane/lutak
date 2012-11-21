# Class: redmine
#
# This modules installs redmine 2.0
#
class redmine {
  package { 'rubygems':                 ensure => latest, }
  package { 'rubygem-rails':            ensure => '3.2.6-1.el6.srce', }
  package { 'rubygem-mocha':            ensure => '0.12.0-1.el6.srce', }
  package { 'rubygem-rmagick':          ensure => '2.13.1-1.el6.srce', }
  package { 'rubygem-prototype-rails':  ensure => '3.2.1-1.el6.srce', }
  package { 'rubygem-coderay':          ensure => '1.0.7-1.el6.srce', }
  package { 'rubygem-fastercsv':        ensure => '1.5.5-1.el6.srce', }
  package { 'rubygem-net-ldap':         ensure => '0.3.1-1.el6.srce', }
  package { 'rubygem-ruby-openid':      ensure => '2.1.8-1.el6.srce', }
  package { 'rubygem-rack-openid':      ensure => '1.3.1-1.el6.srce', }
  # database connectors
  package { 'rubygem-pg':               ensure => '0.14.0-1.el6.srce', }
  package { 'rubygem-sqlite3':          ensure => '1.3.6-1.el6.srce', }
  package { 'rubygem-mysql':            ensure => '2.8.1-1.el6.srce', }
  package { 'rubygem-mysql2':           ensure => '0.3.11-1.el6.srce', }
  # rest
  package { 'rubygem-yard':             ensure => '0.8.2.1-1.el6.srce', }
  package { 'rubygem-shoulda':          ensure => '2.11.3-1.el6.srce', }
  # passenger
  package { 'mod_passenger':            ensure => '3.0.11-9.el6.srce', }
  # get redmine
  exec { 'getredmine' :
    cwd     => '/var/www',
    command => 'wget http://rubyforge.org/frs/download.php/76259/redmine-2.0.3.tar.gz && tar -xzf redmine-2.0.3.tar.gz && rm -f redmine-2.0.3.tar.gz',
    unless  => 'test -f /var/www/redmine-2.0.3/config.ru',
    require => [ Package['httpd'], Package['rubygem-rails'], ],
  }
  # set correct permissions
  file { '/var/www/redmine/log':
    ensure  => directory,
    owner   => apache, group => apache, recurse => true,
    require => Exec['getredmine'],
  }
  # configure redmine
  file { '/var/www/html/redmine' :
    ensure  => link,
    target  => '/var/www/redmine-2.0.3',
    require => Exec['getredmine'],
  }
  file { '/var/www/redmine' :
    ensure  => link,
    target  => 'redmine-2.0.3',
    require => Exec['getredmine'],
  }
  file { '/var/www/redmine/config/database.yml':
    ensure  => present,
    mode    => '0644',
    content => template('redmine/database.yml.erb'),
    require => File['/var/www/redmine'],
  }
  file { '/var/www/redmine/config/email.yml':
    ensure  => present,
    mode    => '0644',
    content => template('redmine/email-gmailtls.yml.erb'),
    require => File['/var/www/redmine'],
  }
  # plugin folder
  file { '/var/www/redmine/plugins':
    ensure => directory,
    mode   => '0755',
  }
  # add /redmine alias to Apache
  file { '/etc/httpd/conf.d/redmine.conf':
    ensure  => present,
    mode    => '0644',
    owner   => 'root', group => 'root',
    source  => 'puppet:///modules/redmine/redmine.conf',
    require => [ File['/var/www/redmine'], Package['mod_passenger'], ],
    notify  => Service['httpd'],
  }
}
