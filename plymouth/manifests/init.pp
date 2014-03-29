#
# = Class: plymouth
#
# Installs and sets up PlyMouth splash screen
class plymouth (
  $theme = 'details',
){
  package { 'plymouth': ensure => present, }

  file { '/etc/plymouth/plymouthd.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('plymouth/plymouthd.conf.erb'),
    require => Package['plymouth'],
  }

  case $theme {
    default:      {}
    'rings':      { include ::plymouth::theme::rings      }
    'spinfinity': { include ::plymouth::theme::spinfinity }
    'solar':      { include ::plymouth::theme::solar      }
    'fade-in':    { include ::plymouth::theme::fadein     }
  }

  exec { 'set_plymouth_theme':
    command => "/usr/sbin/plymouth-set-default-theme ${theme} && /usr/libexec/plymouth/plymouth-update-initrd",
    unless  => "/usr/sbin/plymouth-set-default-theme | /bin/grep -q ${theme}",
  }

}
