# Class: umd::voms::fedcloud-egi-eu
#
# This module installs VOMS config for fedcloud.egi.eu
#
class umd::voms::fedcloud-egi-eu {
  require umd::voms

  file { '/etc/grid-security/vomsdir/fedcloud.egi.eu':
      ensure => directory,
      purge  => true,
      owner  => root,
      group  => root,
      mode   => '0755',
  }

  file { '/etc/grid-security/vomsdir/fedcloud.egi.eu/voms1.egee.cesnet.cz.lsc':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => [
      'puppet:///modules/umd/voms/fedcloud.egi.eu/voms1.egee.cesnet.cz.lsc',
    ],
    require => [ Package['ca-policy-egi-core'], File['/etc/grid-security/vomsdir/fedcloud.egi.eu'] ],
  }
  file { '/etc/grid-security/vomsdir/fedcloud.egi.eu/voms2.grid.cesnet.cz.lsc':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => [
      'puppet:///modules/umd/voms/fedcloud.egi.eu/voms2.grid.cesnet.cz.lsc',
    ],
    require => [ Package['ca-policy-egi-core'], File['/etc/grid-security/vomsdir/fedcloud.egi.eu'] ],
  }
}
