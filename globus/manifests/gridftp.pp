# Class: globus::gridftp
#
# Installs Globus Toolkit GridFTP server
#
class globus::gridftp (
  $tcp_range = $globus::tcp_range,
) inherits globus {
  include gridcert::crl
  require gridcert

  package { 'globus-gridftp-server-progs':
    ensure => present,
  }
  file { '/etc/sysconfig/globus-gridftp-server':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['globus-gridftp-server-progs'],
    content  => template('globus/globus-gridftp-server.erb'),
  }
  file { '/etc/gridftp.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['globus-gridftp-server-progs'],
    source  => 'puppet:///modules/globus/gridftp.conf',
  }
  service { 'globus-gridftp-server':
    enable    => true,
    ensure    => running,
    provider  => redhat,
    require   => [ File['/etc/sysconfig/globus-gridftp-server'], File['/etc/gridftp.conf'] ],
  }
}
