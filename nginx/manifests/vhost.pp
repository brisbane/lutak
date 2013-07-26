# Define: nginx::vhost
#
# This definition creates a new virtual host
#
# Parameters:
#   [*ensure*]           - Enables or disables the specified location (present|absent)
#   [*listen_ip*]        - Default IP Address for NGINX to listen with this vHost on. Defaults to all interfaces (*)
#   [*listen_port*]      - Default IP Port for NGINX to listen with this vHost on. Defaults to TCP 80
#   [*ipv6_enable*]      - BOOL value to enable/disable IPv6 support (false|true). Module will check to see if IPv6
#                          support exists on your system before enabling.
#   [*ipv6_listen_ip*]   - Default IPv6 Address for NGINX to listen with this vHost on. Defaults to all interfaces (::)
#   [*ipv6_listen_port*] - Default IPv6 Port for NGINX to listen with this vHost on. Defaults to TCP 80
#   [*index_files*]      -  Default index files for NGINX to read when traversing a directory
#   [*proxy*]            - Proxy server(s) for a location to connect to. Accepts a single value, can be used in conjunction
#                          with nginx::resource::upstream
#   [*ssl*]              - Indicates whether to setup SSL bindings for this location.
#   [*ssl_cert*]         - Pre-generated SSL Certificate file to reference for SSL Support. This is not generated by this module.
#   [*ssl_key*]          - Pre-generated SSL Key file to reference for SSL Support. This is not generated by this module.
#   [*www_root*]         - Specifies the location on disk for files to be read from. Cannot be set in conjunction with $proxy
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  nginx::resource::vhost { 'test2.local':
#    ensure   => present,
#    www_root => '/var/www/nginx-default',
#    ssl      => 'true',
#    ssl_cert => '/tmp/server.crt',
#    ssl_key  => '/tmp/server.pem',
#  }
define nginx::vhost (
  $listen,
  $docroot,
  $docroot_owner = 'root',
  $docroot_group = 'root',
  $index         = ['index.html', 'index.htm', 'index.php'],
  $ssl           = false,
  $ssl_cert      = undef,
  $ssl_key       = undef,
  $template      = 'nginx/vhost/header.erb',
  $priority      = 'vhost',
  $log_dir       = '',
  $servername    = undef,
) {
  include nginx

  # set the server name correctly
  if $servername == '' {
    $srvname = $name
  } else {
    $srvname = $servername
  }

  # set the logroot correctly
  if $log_dir == '' {
    $logroot = $::nginx::log_dir
  } else {
    $logroot = $log_dir
  }

  # Check to see if SSL Certificates are properly defined.
  if ($ssl == true) {
    if ($ssl_cert == undef) or ($ssl_key == undef) {
      fail('nginx: SSL certificate/key (ssl_cert/ssl_cert) and/or SSL Private must be defined and exist on the target system(s)')
    }
  }

  # This ensures that the docroot exists
  # But enables it to be specified across multiple vhost resources
  if ! defined(File[$docroot]) {
    file { $docroot:
      ensure => directory,
      owner  => $docroot_owner,
      group  => $docroot_group,
    }
  }

  # vhost configuration file
  # we use concat
  $concat_notify = $::nginx::manage_service ? {
    default => undef,
    true    => Service['nginx'],
  }
  $concat_require = $ssl ? {
    default => undef,
    true    => File[$ssl_cert, $ssl_key],
  }
  concat { "nginx_vhost_${name}":
    path    => "${::nginx::conf_dir}/conf.d/${priority}-${name}.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => $concat_notify,
    require => $concat_require,
  }
  # fragments
  concat::fragment { "nginx_${name}_header":
    target  => "nginx_vhost_${name}",
    content => template($template),
    order   => '100',
  }
  concat::fragment { "nginx_${name}_footer":
    target  => "nginx_vhost_${name}",
    content => '}',
    order   => '300',
  }

}