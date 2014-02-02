# Define: zabbix20::server::config
define zabbix20::server::config (
  $settings,
  $notify_service = true,
) {
  include ::zabbix20::server

  $service_to_notify = $notify_service ? {
    default => undef,
    true    => Service['zabbix-server'],
  }

  file { "/etc/zabbix/server-conf.d/${name}.conf":
    ensure  => file,
    content => template('zabbix20/custom.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/zabbix/server-conf.d'],
    notify  => $service_to_notify,
  }

}
