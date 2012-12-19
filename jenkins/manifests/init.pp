# Class: jenkins
#
# This module manages jenkins
#
class jenkins (
  $package_ensure = $jenkins::params::package_ensure,
  $java_version   = $jenkins::params::java_version,
) inherits jenkins::params {
  require yum::repo::jenkins
  require "java::sun${java_version}"

  package { 'jenkins':
    ensure  => $package_ensure,
    require => [ Package["java-1.${java_version}.0-sun-devel"], File['/etc/yum.repos.d/jenkins.repo'], ],
  }
  service { 'jenkins':
    ensure  => running,
    enable  => true,
    require => Package['jenkins'],
  }
}
