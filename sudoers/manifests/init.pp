class sudoers {
  package { 'sudo':
    ensure => present,
  }
  file { '/etc/sudoers.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0750',
    require => Package['sudo'],
  }
  exec {'add_sudo_include_d':
    command => '/bin/echo "includedir /etc/sudoers.d" >> /etc/sudoers',
    unless  => '/bin/grep -q "includedir /etc/sudoers.d" /etc/sudoers',
    require => File['/etc/sudoers.d'],
  }
}
