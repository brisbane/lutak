# Define: apache::vhost::proxy
#
# Configures an apache vhost that will only proxy requests
#
# Parameters:
# * $port:
#     The port on which the vhost will respond
# * $dest:
#     URI that the requests will be proxied for
# - $priority
# - $template -- the template to use for the vhost
# - $vhost_name - the name to use for the vhost, defaults to '*'
#
# Actions:
# * Install Apache Virtual Host
#
# Requires:
#
# Sample Usage:
#
class apache::namevirtualhost (
  $template         = 'apache/namevirtualhost.conf.erb',
  $namevirtualhosts = ['*:80'],
) {
  include apache

  file { 'namevirtualhost.conf':
    path    => "${apache::params::vdir}/namevirtualhost.conf",
    content => template($template),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['httpd'],
    notify  => Service['httpd'],
  }
}
