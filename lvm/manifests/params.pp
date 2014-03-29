# Class: lvm::params
class lvm::params {

  case $::osfamily {
    default: {
      $package_name = 'lvm'
    }
    'redhat': {
      $package_name = 'lvm2'
    }
  }

}
