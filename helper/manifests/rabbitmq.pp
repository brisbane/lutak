#
# = Class: helper::rabbitmq
#
# This class wraps create_resources around hiera hashes for RabbitMQ stuff
class helper::rabbitmq {
  include ::rabbitmq

  # vhosts
  $rabbitmq_vhosts = hiera_array('rabbitmq::vhosts', [])
  rabbitmq_vhost { $rabbitmq_vhosts : }

  # exchanges
  $rabbitmq_exchanges = hiera_hash('rabbitmq::exchanges', {})
  create_resources(rabbitmq_exchange, $rabbitmq_exchanges)

  # create rabbitmq users
  $rabbitmq_users = hiera_hash('rabbitmq::users', {})
  create_resources(rabbitmq_user, $rabbitmq_users)

  # set permissions for rabbitmq users
  $rabbitmq_user_permissions = hiera_hash('rabbitmq::user_permissions', {})
  create_resources(rabbitmq_user_permissions, $rabbitmq_user_permissions)

  # enable plugins
  $rabbitmq_plugins = hiera_array('rabbitmq::plugins', [])
  rabbitmq_plugin { $rabbitmq_plugins : }

}
