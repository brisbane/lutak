# Class: mcollective::mqserver
#
# This module manages mcollective server,
# and installs only on master
#
# Requires:
#   $mcollective_master   must be set in hiera
#   $mcollective_user     must be set in hiera
#   $mcollective_password must be set in hiera
#
# Sample Usage:
#   include mcollective
#
class mcollective::mqserver (
  $package_ensure = $mcollective::params::package_ensure,
) inherits mcollective::params {
  package { 'rabbitmq-server':
    ensure  => $package_ensure,
  }
  # get version of plugins depending on RabbitMQ version
  file { "/usr/lib/rabbitmq/lib/rabbitmq_server-${::rabbitmqversion}/plugins/amqp_client-${::rabbitmqversion}.ez":
    ensure   => present,
    source   => "puppet:///modules/mcollective/rabbitmq/amqp_client-${::rabbitmqversion}.ez",
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    require  => Package['rabbitmq-server'],
  }
  file { "/usr/lib/rabbitmq/lib/rabbitmq_server-${::rabbitmqversion}/plugins/rabbitmq_stomp-${::rabbitmqversion}.ez":
    ensure   => present,
    source   => "puppet:///modules/mcollective/rabbitmq/rabbitmq_stomp-${::rabbitmqversion}.ez",
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    require  => Package['rabbitmq-server'],
  }
  file { '/etc/rabbitmq/rabbitmq-env.conf':
    ensure   => present,
    content  => template('mcollective/rabbitmq-env.conf.erb'),
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    require  => [ Package['rabbitmq-server'], File["/usr/lib/rabbitmq/lib/rabbitmq_server-${::rabbitmqversion}/plugins/amqp_client-${::rabbitmqversion}.ez"], File["/usr/lib/rabbitmq/lib/rabbitmq_server-${::rabbitmqversion}/plugins/rabbitmq_stomp-${::rabbitmqversion}.ez"], ],
    notify   => Service['rabbitmq-server'],
  }
  service { 'rabbitmq-server':
    ensure   => 'running',
    enable   => true,
    provider => 'redhat',
    require  => File['/etc/rabbitmq/rabbitmq-env.conf'],
  }
}
