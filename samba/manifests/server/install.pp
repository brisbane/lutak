class samba::server::install {
  package { 'samba':
    ensure => present,
  }
  package {'samba-winbind':
    ensure => present,
  }
}
