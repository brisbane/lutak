class cobbler::distro (
) inherits cobbler {
  define add_distro ($arch,$isolink) {
    $distro = $title
    $server_ip = $cobbler::server_ip
    cobblerdistro { $distro :
      ensure  => present,
      arch    => $arch,
      isolink => $isolink,
      destdir => $cobbler::distro_path,
      require => Service[$cobbler::service_name],
    }
    $defaultrootpw = $cobbler::defaultrootpw
    file { "$cobbler::distro_path/kickstarts/$distro.ks":
      ensure  => present,
      content => template("cobbler/$distro.ks.erb"),
      require => File["$cobbler::distro_path/kickstarts"],
    }
  }
  define del_distro (){
    include cobbler
    $distro = $title
    cobblerdistro { $distro :
      ensure  => absent,
      destdir => $cobbler::distro_path,
      require => Service[$cobbler::service_name],
    }
    file { "$cobbler::distro_path/kickstarts/$distro.ks":
      ensure  => absent,
    }
  }
}
