# Class: apache::mod::xsendfile
class apache::mod::xsendfile (
) inherits apache::params {

  apache::mod { 'xsendfile': }
  # Template uses $proxy_requests
  # file { "${apache::params::vdir}/xsendfile.conf":
  #   ensure  => present,
  #   source  => 'puppet:///modules/apache/xsendfile.conf',
  # }
}
