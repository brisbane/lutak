# Class: apache::nessus
#
# This class adds fixes to apache for vulnerabilities
# found by Nessus. Typical example is TRACK/TRACE disable.
class apache::nessus (
  $vdir = $apache::vdir,
) inherits apache {
  file { "${vdir}/nessus_fixes.conf":
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/apache/nessus_fixes.conf',
    notify => Service['httpd'],
  }
}
