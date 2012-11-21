class apache::mod::proxy (
  $proxy_requests = "Off",
  $proxy_allow    = '127.0.0.1/8',
) inherits apache::params {
  apache::mod { 'proxy': }
  # Template uses $proxy_requests
  file { "${apache::params::vdir}/proxy.conf":
    ensure  => present,
    content => template('apache/mod/proxy.conf.erb'),
  }
}
