# Class: tomcat$major
#
# This module manages Tomcat installation for CentOS
#
class tomcat (
  $major          = $tomcat::params::major,
  $package_ensure = $tomcat::params::package_ensure,
) inherits tomcat::params {
  # packages from CentOS base
  package { 'tomcat':
    ensure => $package_ensure,
    name   => "tomcat${major}",
  }

  service { 'tomcat':
    ensure  => running,
    enable  => true,
    name    => "tomcat${major}",
    require => Package['tomcat'],
  }

}
