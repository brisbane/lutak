define cobbler::add_distro ($arch,$isolink) {
  include cobbler
  $distro = $title
  $server_ip = $cobbler::server_ip
  cobblerdistro { $distro :
    ensure  => present,
    arch    => $arch,
    isolink => $isolink,
    destdir => $cobbler::distro_path,
    require => [ Service[$cobbler::service_name], Service[$cobbler::apache_service] ],
  }
  $defaultrootpw = $cobbler::defaultrootpw
  file { "$cobbler::distro_path/kickstarts/$distro.ks":
    ensure  => present,
    content => template("cobbler/$distro.ks.erb"),
    require => File["$cobbler::distro_path/kickstarts"],
  }
}
