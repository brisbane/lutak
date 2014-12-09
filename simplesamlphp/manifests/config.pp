# Class: simplesamlphp::config
class simplesamlphp::config {

  file { '/etc/simplesamlphp/authsources.php':
    ensure  => file,
    content => template('srce/simplesamlphp/authsources.php.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
  }

  case $::osfamily {
    'RedHat' : {
      file { '/usr/share/simplesamlphp/metadata/saml20-idp-remote.php':
        ensure => file,
        source => 'puppet:///modules/simplesamlphp/saml20-idp-remote.php',
        owner  => root,
        group  => root,
        mode   => '0644',
      }
      file { '/etc/simplesamlphp/config.php':
        ensure  => file,
        content => template('srce/simplesamlphp/config.php.erb'),
        owner   => root,
        group   => root,
        mode    => '0644',
      }
      file { '/etc/httpd/conf.d/simplesamlphp.conf':
        ensure  => file,
        content => template('srce/simplesamlphp/simplesamlphp.conf.erb'),
        owner   => root,
        group   => root,
        mode    => '0644',
      }
      exec { 'service httpd reload':
        subscribe   => File['/etc/httpd/conf.d/simplesamlphp.conf'],
        refreshonly => true,
      }
    }
    'Debian': {
      file { '/etc/simplesamlphp/metadata/saml20-idp-remote.php':
        ensure => file,
        source => 'puppet:///modules/simplesamlphp/saml20-idp-remote.php',
        owner  => root,
        group  => root,
        mode   => '0644',
      }
      file { '/etc/simplesamlphp/config.php':
        ensure  => file,
        content => template('srce/simplesamlphp/config_debian.php.erb'),
        owner   => root,
        group   => root,
        mode    => '0644',
      }
      file { '/etc/apache2/conf.d/simplesamlphp-aai.conf':
        ensure  => file,
        content => template('srce/simplesamlphp/simplesamlphp.conf.erb'),
        owner   => root,
        group   => root,
        mode    => '0644',
      }
      exec { 'service apache2 reload':
        subscribe   => File['/etc/apache2/conf.d/simplesamlphp-aai.conf'],
        refreshonly => true,
      }
    }
    default: { }
  }

  if $simplesamlphp::authmemcookie == true {
    file { '/etc/simplesamlphp/authmemcookie.php':
      ensure  => file,
      content => template('srce/simplesamlphp/authmemcookie.php.erb'),
      owner   => root,
      group   => root,
      mode    => '0644',
    }
    case $::osfamily {
      'RedHat'  : {
        file { '/etc/httpd/conf.d/authmemcookie.conf':
          ensure  => file,
          content => template('srce/simplesamlphp/authmemcookie.conf.erb'),
          owner   => root,
          group   => root,
          mode    => '0644',
        }
        exec { 'reload httpd service for authmemcookie':
          subscribe   => File['/etc/httpd/conf.d/authmemcookie.conf'],
          command     => 'service httpd reload',
          refreshonly => true,
        }
      }
      'Debian' : {
        file { '/etc/apache2/mods-enabled/auth_memcookie.load':
          ensure => link,
          target => '/etc/apache2/mods-available/auth_memcookie.load',
        }
        exec { 'reload apache2 service for authmemcookie':
          subscribe   => File['/etc/apache2/mods-enabled/auth_memcookie.load'],
          command     => 'service apache2 reload',
          refreshonly => true,
        }
      }
      default: { }
    }
  }

}
