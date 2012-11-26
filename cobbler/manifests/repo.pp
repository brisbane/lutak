class cobbler::repo inherits cobbler {
  define add_repo ($arch,$mirror,$mirrorlocally,$priority) {
    $repo = $title
    cobblerrepo { $repo:
      ensure        => present,
      arch          => $arch,
      mirror        => $mirror,
      mirrorlocally => $mirrorlocally,
      priority      => $priority,
      require       => [ Service[$cobbler::service_name], Service[$cobbler::apache_service] ],
    }
  }
  define del_repo (){
    $repo = $title
    cobblerrepo { $repo :
      ensure  => absent,
      require => [ Service[$cobbler::service_name], Service[$cobbler::apache_service] ],
    }
  }
}
