#
# = Class: desktop
#
# [*displaymanager*]
#  - Sets the DM (login screen).
class desktop (
  $displaymanager = 'KDE'
){
  file { '/etc/sysconfig/desktop':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('desktop/desktop.erb'),
  }

  case $displaymanager {
    default : {}
    /GNOME/ : { include ::desktop::dm::gdm }
    /KDE/   : { include ::desktop::dm::kdm }
    /XDM/   : { include ::desktop::dm::xdm }
  }

}
