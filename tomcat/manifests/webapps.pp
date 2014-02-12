# Class: tomcat::webapps
#
# This module manages Tomcat Webapps
#
class tomcat::webapps (
  $major          = $tomcat::major,
  $package_ensure = $tomcat::package_ensure,
) inherits tomcat {
  # packages from CentOS base
  package { 'tomcat-webapps':
    ensure => $package_ensure,
    name   => "tomcat${major}-webapps",
  }
  package { 'tomcat-admin-webapps':
    ensure => $package_ensure,
    name   => "tomcat${major}-admin-webapps",
  }
}
