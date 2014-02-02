# define: nginx::resource::location
#
# This definition creates a new location entry within a virtual host
#
# Parameters:
#   [*ensure*]      - Enables or disables the specified location (present|absent)
#   [*vhost*]       - Defines the default vHost for this location entry to include with
#   [*location*]    - Specifies the URI associated with this location entry
#   [*www_root*]    - Specifies the location on disk for files to be read from. Cannot be set in conjunction with $proxy
#   [*index_files*] - Default index files for NGINX to read when traversing a directory
#   [*proxy*]       - Proxy server(s) for a location to connect to. Accepts a single value, can be used in conjunction
#                     with nginx::resource::upstream
#   [*ssl*]         - Indicates whether to setup SSL bindings for this location.
#   [*option*]      - Reserved for future use
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  nginx::resource::location { 'test2.local-bob':
#    location => '/bob',
#    www_root => '/var/www/bob',
#    vhost    => 'test2.local',
#  }
define nginx::location (
  $location,
  $ensure   = present,
  $vhost    = undef,
  $template = 'nginx/vhost/location.erb',
) {

  # vhost must be defined
  if ($vhost == undef) {
    fail('Cannot create a location reference without attaching to a virtual host')
  }

  concat::fragment { "nginx_location_${name}":
    target  => "nginx_vhost_${vhost}",
    content => template($template),
    order   => '250',
  }

}
