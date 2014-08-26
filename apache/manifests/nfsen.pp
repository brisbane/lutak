# Class: apache::nfsen
#
# This class adds nfsen configuration
class apache::nfsen (
  $vdir = $apache::vdir,
) inherits apache {
  file { "${vdir}/nfsen.conf":
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/apache/nfsen.conf',
    notify => Service['httpd'],
  }
}
