# Class: nginx::config
#
# This class provides some advanced nginx settings
#
# Parameters:
#   [*server_names_hash_bucket_size*] - maximum length of a virtual host entry
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  nginx::config {
#    server_names_hash_bucket_size => '64',
#  }
class nginx::config (
  $server_names_hash_bucket_size = undef,
) {
  include nginx

  $curnotify = $::nginx::manage_service ? {
    default => undef,
    true    => Service['nginx'],
  }

  file { "${::nginx::conf_dir}/conf.d/advanced_config.conf":
    ensure  => file,
    owner   => root,
    group   => root,
    content => template('nginx/advanced_config.erb'),
    notify  => $curnotify,
  }

}
