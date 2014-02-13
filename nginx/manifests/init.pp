# Class: nginx
#
# This module manages NGINX.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters are
# managed via the nginx::params class
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
#  Packaged NGINX
#    - RHEL: EPEL or custom package
#    - Debian/Ubuntu: Default Install or custom package
#    - SuSE: Default Install or custom package
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include nginx
# }
class nginx (
  $manage_service     = $::nginx::params::manage_service,
  $conf_dir           = $::nginx::params::conf_dir,
  $log_dir            = $::nginx::params::log_dir,
  $pid_file           = $::nginx::params::pid_file,
  $daemon_user        = $::nginx::params::daemon_user,
  $multi_accept       = $::nginx::params::multi_accept,
  $worker_processes   = $::nginx::params::worker_processes,
  $worker_connections = $::nginx::params::worker_connections,
  $sendfile           = $::nginx::params::sendfile,
  $tcp_nopush         = $::nginx::params::tcp_nopush,
  $keepalive_timeout  = $::nginx::params::keepalive_timeout,
  $tcp_nodelay        = $::nginx::params::tcp_nodelay,
  $gzip               = $::nginx::params::gzip,
) inherits nginx::params {

  include ::nginx::config

  File {
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['nginx'],
  }

  # install nginx
  package { 'nginx': ensure => present, }

  # create dirs
  file { $conf_dir: ensure => directory, }
  file { "${conf_dir}/conf.d":
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

  # main config file
  file { "${conf_dir}/nginx.conf":
    content => template('nginx/nginx.conf.erb'),
  }

  # manage nginx service
  if $manage_service == true {
    service { 'nginx':
      ensure     => running,
      enable     => true,
      subscribe  => [
        File["${conf_dir}/nginx.conf"],
        File["${conf_dir}/conf.d"],
      ],
    }
  }
}
