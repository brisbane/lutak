# Class: fail2ban
class fail2ban (
  $global_ignore   = $fail2ban::params::global_ignore,
  $global_bantime  = $fail2ban::params::global_bantime,
  $global_maxretry = $fail2ban::params::global_maxretry,
) inherits fail2ban::params {
  require yum::repo::srce

  package{'fail2ban':
    ensure  => latest,
  }
  file { '/etc/fail2ban/fail2ban.conf' :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    require => Package['fail2ban'],
    notify  => Service['fail2ban'],
  }
  file { '/etc/fail2ban/jail.conf' :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    require => Package['fail2ban'],
    notify  => Service['fail2ban'],
    content => template('fail2ban/jail.conf.erb'),
  }
  file { '/etc/fail2ban/action.d' :
    ensure  => directory,
    recurse => false,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package['fail2ban'],
    notify  => Service['fail2ban'],
  }
  file { '/etc/fail2ban/filter.d' :
    ensure  => directory,
    recurse => false,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package['fail2ban'],
    notify  => Service['fail2ban'],
  }
  service { 'fail2ban' :
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['fail2ban'],
  }
}
