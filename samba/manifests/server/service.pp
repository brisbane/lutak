class samba::server::service {
  service { 'smb':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['samba::server::config']
  }
  service { 'nmb':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['samba::server::config']
  }
  service { 'winbind':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['samba::server::config']
  }
}
