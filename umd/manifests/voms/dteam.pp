# Class: umd::voms::dteam
#
# This module installs VOMS config for dteam
#
class umd::voms::dteam {
  require umd::voms

  file { '/etc/grid-security/vomsdir/dteam':
      ensure => directory,
      purge  => true,
      owner  => root,
      group  => root,
      mode   => '0755',
  }

  file { '/etc/grid-security/vomsdir/dteam/voms.hellasgrid.gr.lsc':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => [
      'puppet:///modules/umd/voms/dteam/voms.hellasgrid.gr.lsc',
    ],
    require => [ Package['ca-policy-egi-core'], File['/etc/grid-security/vomsdir/dteam'] ],
  }
  file { '/etc/grid-security/vomsdir/dteam/voms2.hellasgrid.gr.lsc':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => [
      'puppet:///modules/umd/voms/dteam/voms2.hellasgrid.gr.lsc',
    ],
    require => [ Package['ca-policy-egi-core'], File['/etc/grid-security/vomsdir/dteam'] ],
  }
}
