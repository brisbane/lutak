# Define: zabbix20::server::config
define zabbix20::server::config (
  $settings,
  $notify_service = true,
) {
  include ::zabbix20::server

  file { "/etc/zabbix/server-conf.d/${name}.conf":
    ensure  => file,
    content => template('zabbix20/custom.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/zabbix/server-conf.d'],
  }

  if $notify_service {
    File["/etc/zabbix/server-conf.d/${name}.conf"] {
      # XXX notifying the Service gives us a dependency circle but I don't understand why
      notify => Service['zabbix-server'],
    }
  }
}
