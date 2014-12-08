# Class: apache::mod::rpaf
class apache::mod::rpaf (
  $sethostname = true,
  $proxy_ips   = [ '127.0.0.1' ],
  $header      = 'X-Forwarded-For',
  $template    = $::apache::params::mod_rpaf_template,
) {
  ::apache::mod { 'rpaf': }

  include ::apache::params
  # Template uses:
  # - $sethostname
  # - $proxy_ips
  # - $header
  file { 'rpaf.conf':
    ensure  => file,
    path    => "${::apache::mod_dir}/rpaf.conf",
    content => template($template),
    require => Exec["mkdir ${::apache::mod_dir}"],
    before  => File[$::apache::mod_dir],
    notify  => Service['httpd'],
  }
}
