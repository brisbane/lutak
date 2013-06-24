# Class: vmtools::xvpweb
#
# Installs the XVP Web
class vmtools::xvpweb (
  $package_ensure   = 'present',
  $pool             = 'Pool1',
  $domain           = '',
  $manager_user     = 'root',
  $manager_password,
  $hosts            = [],
  $vms              = [],
){

  package { [ 'xvp', 'xvpweb' ] :
    ensure => $package_ensure,
  }
  file { '/etc/httpd/conf.d/xvpweb.conf':
    require => Package['xvpweb'],
  }

  # note: you can use 'xvpdiscover' from package
  #       'xvp' to populate this file for you
  file { '/etc/xvp.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('vmtools/xvp.conf.erb'),
  }

  # manage service
  service { 'xvp':
    ensure  => running,
    enable  => true,
    require => [
      Package['xvp'],
      File['/etc/xvp.conf'],
    ],
  }

}
