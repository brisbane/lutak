# Class: apache::mod::passenger
class apache::mod::passenger (
) inherits apache::params {
  # require yum::repo::passenger

  apache::mod { 'passenger': }
  # Template uses $proxy_requests
  file { "${apache::params::vdir}/passenger.conf":
    ensure  => present,
    content => template('apache/mod/passenger.conf.erb'),
  }
}
