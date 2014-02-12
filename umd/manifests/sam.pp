# Class: umd::sam
#
# This modules installs SAM
#
class umd::sam (
  $ensure_version = '1.22.0-9.el5',
  $site_info_source = 'puppet:///private/umd/site-info.def',
) {
  require gridcert

  package { 'httpd':
    ensure  => latest,
  }
  package { 'nagios.x86_64':
    ensure  => latest,
    require => [ Package ['httpd'] ],
  }
  package { 'mysql51':
    ensure  => latest,
  }
  package { 'yum-plugin-replace':
    ensure  => latest,
  }
  package { 'sam-nagios' :
    ensure  => $ensure_version,
    require => [ Package['nagios.x86_64'], Package['yum-plugin-replace'], Package['mysql51'] ],
  }

  file { '/opt/glite/yaim/etc/site-info.def':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0600',
    source  => $site_info_source,
    require => Package['sam-nagios'],
  }

  exec { 'sam-yaim':
    command => '/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n NAGIOS -n SAM_NAGIOS && rpm -q sam-nagios > /opt/glite/yaim/etc/sam.info',
    unless  => 'test -f /opt/glite/yaim/etc/sam.info',
    require => [ File['/opt/glite/yaim/etc/site-info.def'], Package['sam-nagios'] ],
    timeout => 0,
  }
}
