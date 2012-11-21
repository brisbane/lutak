# modules/koji/builder.pp - manage koji builder
#
class koji::builder {
  package {'koji-builder':
    ensure  => present,
    require => Class['yumreposd::epel'],
  }
  file {'/etc/kojid/kojid.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('koji/kojid.conf.erb'),
    require => Package['koji-builder'],
  }
  package {'mock':
    ensure  => present,
    require => Class['yumreposd::epel'],
  }
  package {'rpm-build':
    ensure  => present,
    require => Class['yumreposd::base'],
  }
}
