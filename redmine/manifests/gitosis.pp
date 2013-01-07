# Class: redmine::gitosis
#
# This modules installs Gitosis plugin for RedMine
#
class redmine::gitosis {
  # gitosis plugin prerequisites
  package { 'rubygem-inifile':   ensure => '1.1.0-1.el6.srce', }
  package { 'rubygem-lockfile':  ensure => '2.1.0-1.el6.srce', }
  package { 'rubygem-net-ssh':   ensure => '2.5.2-1.el6.srce', }
  # get redmine_gitosis
  exec { 'getredminegitosis' :
    cwd     => '/var/www/redmine/plugins',
    command => 'git clone https://github.com/rocket-rentals/redmine-gitosis && mv redmine-gitosis redmine_gitosis',
    unless  => 'test -f /var/www/redmine/plugins/redmine_gitosis/init.rb',
    require => [ Class['redmine'], Package['rubygem-inifile'], Package['rubygem-lockfile'], Package['rubygem-net-ssh'] ],
  }
  # config repositories location
  file { '/var/www/redmine/plugins/redmine_gitosis/lib/gitosis.rb':
    ensure  => present,
    mode    => '0644',
    content => template('redmine/gitosis.rb.erb'),
    require => [ File['/var/www/redmine/plugins'], Exec['getredminegitosis'] ],
  }
  file { '/var/www/redmine/plugins/redmine_gitosis/app/models/gitosis_public_key.rb':
    ensure  => present,
    mode    => '0644',
    owner   => apache,
    group   => apache,
    source  => 'puppet:///modules/redmine/gitosis_public_key.rb',
    require => [ File['/var/www/redmine/plugins'], Exec['getredminegitosis'] ],
  }
  file { '/var/www/redmine-2.0.3/plugins/redmine_gitosis/config/routes.rb':
    ensure  => present,
    mode    => '0644',
    owner   => apache,
    group   => apache,
    source  => 'puppet:///modules/redmine/routes.rb',
    require => [ File['/var/www/redmine/plugins'], Exec['getredminegitosis'] ],
  }

  # TODO:
  # private ssh key with gitosis-admin write rights
  # /var/www/redmine/plugins/redmine_gitosis/extra/ssh/private_key
}
