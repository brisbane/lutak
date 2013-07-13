# Class: samba::server
class samba::server(
  $major                 = $samba::params::major,
  $package_ensure        = $samba::params::package_ensure,
  $workgroup             = $samba::params::workgroup,
  $realm                 = $samba::params::realm,
  $security              = $samba::params::security,
  $allow_trusted_domains = $samba::params::allow_trusted_domains,
  $password_server       = $samba::params::password_server,
  $interfaces            = $samba::params::interfaces,
  $syslog                = $samba::params::syslog,
  $logfile               = $samba::params::logfile,
  $load_printers         = $samba::params::load_printers,
  $cups_options          = $samba::params::cups_options,
  $domain_master         = $samba::params::domain_master,
  $local_master          = $samba::params::local_master,
  $idmap_backend         = $samba::params::idmap_backend,
  $idmap_range           = $samba::params::idmap_range,
  $winbind_use_defdomain = $samba::params::winbind_use_defdomain,
  $winbind_enum_users    = $samba::params::winbind_enum_users,
  $winbind_enum_groups   = $samba::params::winbind_enum_groups,
  $winbind_nested_groups = $samba::params::winbind_nested_groups,
  $ad_user               = '',
  $ad_password           = '',
) inherits samba::params {

  Service {
    ensure  => running,
    enable  => true,
  }

  # packages
  package { "samba${major}":
    ensure => $package_ensure,
    alias  => 'samba',
  }

  # config dir
  file { '/etc/samba':
    ensure  => directory,
    mode    => '0755',
    require => Package['samba'],
  }

  service { 'smb': subscribe => Concat['/etc/samba/smb.conf'], }
  service { 'nmb': subscribe => Concat['/etc/samba/smb.conf'], }

  # smb.conf
  concat { '/etc/samba/smb.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
  }
  concat::fragment { 'smb_conf:global':
    target  => '/etc/samba/smb.conf',
    content => template('samba/smb.conf.erb'),
    order   => '100',
  }

  # Active Directory
  if upcase($security) == 'ADS' {
    include samba::server::winbind

    package { 'krb5-workstation': ensure => present, }

    file {'/etc/krb5.conf':
      ensure  => present,
      mode    => '0644',
      content => template('samba/krb5.conf.erb'),
      require => Package['krb5-workstation'],
    }

    exec { 'generate_krb_ticket' :
      command => "/bin/echo ${ad_password} | /usr/bin/kinit ${ad_user}@${realm}",
      unless  => '/usr/bin/klist > /dev/null',
    }

    exec { 'join_active_directory_domain' :
      command => "/usr/bin/net ads join -U ${ad_user}%${ad_password}",
      onlyif  => '/usr/bin/net ads testjoin -k 2>&1 | /bin/grep -q "not valid"',
      require => [ Package['samba'], Exec['generate_krb_ticket'], ],
    }
  }

}
