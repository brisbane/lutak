# Class: umd::creamce
#
# This modules installs UMD CREAM-CE and Torque
#
class umd::creamce (
  $creamce_version = '1.1.0-4.sl6',
  $torque_server_version = '1.0.0-2.sl6',
  $torque_utils_version = '2.0.0-1.sl6',
  $cluster_version = '2.0.0-3.sl6',
) inherits umd {
  require gridcert
  include umd::munge

  # EMI CREAM-CE and Torque
  package { 'emi-cream-ce':
    ensure  => $creamce_version,
    require => Service['munge'],
  }
  package { 'emi-torque-server':
    ensure  => $torque_server_version,
  }
  package { 'emi-torque-utils':
    ensure  => $torque_utils_version,
  }
  package { 'emi-cluster':
    ensure  => $cluster_version,
  }
  package { 'sudo':
    ensure  => present,
  }
  file { '/opt/glite/yaim/etc/users.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///files/umd/users.conf',
  }
  file { '/opt/glite/yaim/etc/groups.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///files/umd/groups.conf',
  }
  file { '/opt/glite/yaim/etc/wn-list.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///files/umd/wn-list.conf',
  }
  exec { 'creamce-yaim':
    command => '/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n creamCE -n CLUSTER -n TORQUE_server -n TORQUE_utils && rpm -q emi-cream-ce > /opt/glite/yaim/etc/emi-cream-ce.info',
    unless  => 'test -f /opt/glite/yaim/etc/emi-cream-ce.info',
    require => [ File['/opt/glite/yaim/etc/users.conf'], File['/opt/glite/yaim/etc/wn-list.conf'], File['/opt/glite/yaim/etc/groups.conf'], Package['emi-cream-ce'], Package['emi-torque-server'], Package['emi-torque-utils'], Package['emi-cluster'], Service['munge'], Package['sudo'], File['/opt/glite/yaim/functions/local/config_cluster_gip_glue2'], File['/opt/glite/yaim/functions/local/config_cluster_gip_lrms_dynamic'], File['/opt/glite/yaim/functions/local/config_cluster_gip_scheduler_plugin'], File['/opt/glite/yaim/functions/local/config_maui_cfg'] ],
    timeout => 0,
  }
  file { '/opt/glite/yaim/functions/local/config_cluster_gip_glue2':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/umd/config_cluster_gip_glue2',
  }
  file { '/opt/glite/yaim/functions/local/config_cluster_gip_lrms_dynamic':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/umd/config_cluster_gip_lrms_dynamic',
  }
  #file { '/opt/glite/yaim/functions/local/config_cream_gip':
  #  ensure  => file,
  #  owner   => root,
  #  group   => root,
  #  mode    => '0644',
  #  source  => 'puppet:///modules/umd/config_cream_gip',
  #}
  file { '/opt/glite/yaim/functions/local/config_cluster_gip_scheduler_plugin':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/umd/config_cluster_gip_scheduler_plugin',
  }
  file { '/opt/glite/yaim/functions/local/config_maui_cfg':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/umd/config_maui_cfg',
  }
}
