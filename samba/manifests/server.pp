# Class: samba::server
class samba::server(
  $major                 = $samba::params::major,
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
  $ad_user               = $samba::params::ad_user,
  $ad_password           = $samba::params::ad_password,
) inherits samba::params {

  Package { ensure => installed, }
  File {
    owner => root,
    group => root,
  }

  # packages
  package { "samba${major}":
    alias  => 'samba',
  }
  package { "samba${major}-winbind":
    alias  => 'samba-winbind',
  }
  # config dir
  file { '/etc/samba':
    ensure  => directory,
    mode    => '0755',
    require => Package['samba'],
  }

  # services
  Service {
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
  service { 'smb':
    require => Package['samba'],
  }
  service { 'nmb':
    require => Package['samba'],
  }
  service { 'winbind':
    require => Package['samba-winbind'],
  }

  # join domain
  if upcase($security) == 'ADS' {
    file {'/etc/krb5.conf':
      ensure  => present,
      mode    => '0644',
      content => template('samba/krb5.conf.erb'),
    }
    package {'krb5-workstation': }
    exec {'join_active_directory_domain':
      # command => '/usr/bin/net ads join -U mount%1f2fe65def',
      command => "/usr/bin/net ads join -U ${ad_user}%${ad_password}",
      onlyif  => '/usr/bin/net ads testjoin -k 2>&1 | /bin/grep -q "not valid"',
    }
    file {'/etc/samba/smb.conf':
      ensure  => present,
      mode    => '0644',
      content => template('samba/smb-ads.conf.erb'),
      notify  => Class['samba::server::service']
    }
  }

#   $context = '/files/etc/samba/smb.conf'
#   $target = "target[. = 'global']"
#
#   #
#   # global section of smb.conf
#   #
#   augeas { 'global-section':
#     context => $context,
#     changes => "set ${target} global",
#     require => Class["samba::server::config"],
#     notify => Class['samba::server::service']
#   }
#
#   # workgroup
#   augeas { 'global-workgroup':
#     context => $context,
#     changes => $workgroup ? {
#       default => "set ${target}/workgroup '$workgroup'",
#       ''      => "rm ${target}/workgroup",
#     },
#     require => Augeas['global-section'],
#     notify  => Class['samba::server::service']
#   }
#
#   # realm (AD domain)
#   augeas { 'global-realm':
#     context => $context,
#     changes => $realm ? {
#       default => "set ${target}/realm '$realm'",
#       ''      => "rm ${target}/realm",
#     },
#     require => Augeas['global-section'],
#     notify  => Class['samba::server::service']
#   }
#
#   # server string
#   augeas { 'global-server_string':
#     context => $context,
#     changes => $server_string ? {
#       default => "set \"${target}/server string\" '$server_string'",
#       '' => "rm \"${target}/server string\"",
#     },
#     require => Augeas['global-section'],
#     notify => Class['samba::server::service']
#   }
#
#   # netbios name
#   augeas { 'global-netbios_name':
#     context => $context,
#     changes => $netbios_name ? {
#       default => "set \"${target}/netbios name\" '$netbios_name'",
#       ''      => "rm \"${target}/netbios name\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }
#
#   # security
#   augeas { 'global-security':
#     context => $context,
#     changes => $security ? {
#       default => "set \"${target}/security\" '$security'",
#       '' => "rm \"${target}/security\"",
#     },
#     require => Augeas['global-section'],
#     notify => Class['samba::server::service']
#   }
#
#   # allow trusted domains
#   augeas { 'global-allow_trusted_domains':
#     context => $context,
#     changes => $allow_trusted_domains ? {
#       default => "set \"${target}/allow trusted domains\" '$allow_trusted_domains'",
#       '' => "rm \"${target}/allow trusted domains\"",
#     },
#     require => Augeas['global-section'],
#     notify => Class['samba::server::service']
#   }
#
#   # password server
#   augeas { 'global-password_server':
#     context => $context,
#     changes => $password_server ? {
#       default => "set \"${target}/password server\" '$password_server'",
#       ''      => "rm \"${target}/password server\"",
#     },
#     require => Augeas['global-section'],
#     notify  => Class['samba::server::service']
#   }
#
#   # interfaces
#   augeas { 'global-interfaces':
#     context => $context,
#     changes => $interfaces ? {
#       default => ["set \"${target}/interfaces\" '$interfaces'", "set \"${target}/bind interfaces only\" yes"],
#       '' => ["rm \"${target}/interfaces\"", "rm \"${target}/bind interfaces only\""],
#     },
#     require => Augeas['global-section'],
#     notify => Class['samba::server::service']
#   }
#
#   # syslog
#   augeas { 'global-syslog':
#     context => $context,
#     changes => $syslog ? {
#       default => "set ${target}/syslog '$syslog'",
#       ''      => "rm ${target}/syslog",
#     },
#     require => Augeas['global-section'],
#     notify  => Class['samba::server::service']
#   }
#
#   # logfile
#   augeas { 'global-logfile':
#     context => $context,
#     changes => $logfile ? {
#       default => "set \"${target}/log file\" '$logfile'",
#       ''      => "rm \"${target}/log file\"",
#     },
#     require => Augeas['global-section'],
#     notify  => Class['samba::server::service']
#   }
#
#   # load printers
#   augeas { 'global-load_printers':
#     context => $context,
#     changes => $load_printers ? {
#       default => "set \"${target}/load printers\" '$load_printers'",
#       ''      => "rm \"${target}/load printers\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }
#
#   # cups options
#   augeas { 'global-cups_options':
#     context => $context,
#     changes => $cups_options ? {
#       default => "set \"${target}/cups options\" '$cups_options'",
#       ''      => "rm \"${target}/cups options\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }
#
#   # domain master
#   augeas { 'global-domain_master':
#     context => $context,
#     changes => $domain_master ? {
#       default => "set \"${target}/domain master\" '$domain_master'",
#       ''      => "rm \"${target}/domain master\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }
#
#   # local master
#   augeas { 'global-local_master':
#     context => $context,
#     changes => $local_master ? {
#       default => "set \"${target}/local master\" '$local_master'",
#       ''      => "rm \"${target}/local master\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }
#
#   # idmap backend
#   augeas { 'global-idmap_backend':
#     context => $context,
#     changes => $idmap_backend ? {
#       default => "set \"${target}/idmap backend\" '$idmap_backend'",
#       ''      => "rm \"${target}/idmap backend\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }
#
#   # idmap uid
#   augeas { 'global-idmap_uid':
#     context => $context,
#     changes => $idmap_uid ? {
#       default => "set \"${target}/idmap uid\" '$idmap_uid'",
#       ''      => "rm \"${target}/idmap uid\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }
#
#   # idmap gid
#   augeas { 'global-idmap_gid':
#     context => $context,
#     changes => $idmap_gid ? {
#       default => "set \"${target}/idmap gid\" '$idmap_gid'",
#       ''      => "rm \"${target}/idmap gid\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }
#
#   # winbind use default domain
#   augeas { 'global-winbind_use_defdomain':
#     context => $context,
#     changes => $winbind_use_defdomain ? {
#       default => "set \"${target}/winbind use default domain\" '$winbind_use_defdomain'",
#       ''      => "rm \"${target}/winbind use default domain\"",
#     },
#     require => Augeas['global-section'],
#     notify   => Class['samba::server::service']
#   }

}
