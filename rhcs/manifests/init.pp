# Class: rhcs
#
# This module deploys base RedHah Cluster Suite packages
#
class rhcs (
  $cluster_name = 'default',
  $config_file  = '',
  $ricci_passwd = 'defaultriccipass',
  $ricci_ca_dir = "/etc/puppet/private/${::fqdn}/ricci/ca",
) {
  # defaults
  Package { ensure => present, }

  Service {
    ensure   => running,
    enable   => true,
    provider => redhat,
  }

  File {
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0640',
  }

  # ricci
  # cluster & storage management and configuration daemon

  # generate ricci CA
  $mypath = get_module_path('rhcs')
  if ( generate("${mypath}/scripts/generate_ricci_ca.sh", $ricci_ca_dir) =~ /Success/ ) {
    # set up ricci
    include rhcs::ricci

    # ccs
    # cluster configuration system
    package { 'ccs': }

    # corosync
    package { 'corosync': }
    file { '/etc/corosync/corosync.conf':
      source  => 'puppet:///modules/rhcs/corosync.conf',
      require => Package['corosync'],
    }

    # cman
    # cluster manager
    package { 'cman': }
    file { '/etc/cluster.conf':
      source  => $rhcs::config_file,
    }
    exec { 'clusterinit':
      command => '/bin/cp /etc/cluster.conf /etc/cluster/cluster.conf',
      creates => '/etc/cluster/cluster.conf',
      require => [ Class['rhcs::ricci'], File['/etc/cluster.conf'], Package['cman'] ],
    }
    file { '/etc/cluster/cluster.conf': require => Exec['clusterinit'], }
    service { 'cman': require => [ File['/etc/cluster/cluster.conf'], File['/etc/corosync/corosync.conf'], ], }
    exec { 'clusterupdate':
      command     => '/usr/sbin/ccs_config_validate -f /etc/cluster.conf && /usr/bin/ccs_sync -f /etc/cluster.conf && /usr/sbin/cman_tool version -r',
      unless      => '/usr/bin/diff /etc/cluster.conf /etc/cluster/cluster.conf > /dev/null',
      refreshonly => true,
      subscribe   => File['/etc/cluster.conf'],
      require     => [ Class['rhcs::ricci'], Service['cman'], ],
    }

    # rgmanager
    # resource group manager
    package { 'rgmanager': }
    service { 'rgmanager': require => [ Package['rgmanager'], Service['cman'] ], }
  }
}
