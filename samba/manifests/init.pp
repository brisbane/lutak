# Class: samba
class samba (
  $major          = $samba::params::major,
  $package_ensure = $samba::params::package_ensure,
) inherits samba::params {
  package {"samba${major}-client":
    ensure => $package_ensure,
    alias  => 'samba-client',
  }
}
