# Class: pyqt4
#
# This module manages PyQt4 toolkit
#
class geoip (
  $package_ensure = $geoip::params::package_ensure,
  $geoip_version  = $geoip::params::geoip_version,
){
  # install specific version
  package { 'GeoIP':
    ensure => $package_ensure,
  }
  # package brings directory, but we decide to purge it
  file { '/usr/share/GeoIP':
    ensure  => directory,
    purge   => true,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package['GeoIP'],
  }
  # fetch and manage GeoIP.dat
  exec { 'fetch-geoip':
    command => '/bin/touch /usr/share/GeoIP/GeoIP.dat && /usr/bin/perl /usr/share/doc/GeoIP-1.4.8/fetch-geoipdata.pl > /dev/null 2>&1',
    creates => '/usr/share/GeoIP/GeoIP.dat',
    require => File['/usr/share/GeoIP'],
  }
  file { '/usr/share/GeoIP/GeoIP.dat':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Exec['fetch-geoip'],
  }
  # fetch and manage GeoIP.dat
  exec { 'fetch-geolitecity':
    command => '/bin/touch /usr/share/GeoIP/GeoLiteCity.dat && /usr/bin/perl /usr/share/doc/GeoIP-1.4.8/fetch-geoipdata-city.pl > /dev/null 2>&1',
    creates => '/usr/share/GeoIP/GeoLiteCity.dat',
    require => File['/usr/share/GeoIP'],
  }
  file { '/usr/share/GeoIP/GeoLiteCity.dat':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Exec['fetch-geoip'],
  }
  # files are fetched via cron every month
  file { '/etc/cron.monthly/fetch-geodata':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => template('geoip/fetch-geodata.erb'),
    require => Package['GeoIP'],
  }
}
