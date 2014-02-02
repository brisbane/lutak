# Class: umd::ui
#
# This modules installs UMD UI
#
class umd::ui (
  $ui_version = '2.0.1-1.el6',
) inherits umd {
  package { 'emi-ui':
    ensure  => $ui_version,
  }
  exec { 'ui-yaim':
    command => '/opt/glite/yaim/bin/yaim -c -s /opt/glite/yaim/etc/site-info.def -n UI && rpm -q emi-ui > /opt/glite/yaim/etc/emi-ui.info',
    unless  => 'test -f /opt/glite/yaim/etc/emi-ui.info',
    require => [ File['/opt/glite/yaim/etc/site-info.def'], Package['emi-ui'] ],
    timeout => 0,
  }
}
