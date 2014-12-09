# Class: simplesamlphp::package
class simplesamlphp::package {

  case $::osfamily {
    default: {}
    'RedHat' : {

      package { 'simplesamlphp':
        ensure => $simplesamlphp::package_ensure,
      }

      if $simplesamlphp::authmemcookie == true {
        package { 'mod_auth_memcookie':
          ensure => $simplesamlphp::package_ensure,
        }
        package { 'memcached':
          ensure => $simplesamlphp::package_ensure,
        }
        package { 'php-pecl-memcache':
          ensure => $simplesamlphp::package_ensure,
        }
      }

    }
    'Debian': {
      package { 'simplesamlphp-aai':
        ensure => $simplesamlphp::package_ensure,
      }
      if $simplesamlphp::authmemcookie == true {
        package { 'libapache2-mod-auth-memcookie':
          ensure => $simplesamlphp::package_ensure,
        }
        package { 'memcached':
          ensure => $simplesamlphp::package_ensure,
        }
      }
    }
  }

}
