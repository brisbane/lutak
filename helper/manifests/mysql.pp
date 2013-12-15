#
# = Class: helper::mysql
#
# This class wraps create_resources around hiera hashes for MySQL database
class helper::mysql {
  include ::mysql
  include ::mysql::server
  include ::admintools::mysqltuner

  # create mysql config from hiera data
  create_resources(::mysql::server::config, hiera_hash('mysql::server::configs',{}))
  # create databases
  create_resources(database, hiera_hash('mysql::server::databases',{}))
  # create users
  create_resources(database_user, hiera_hash('mysql::server::users',{}))
  # create database grants
  create_resources(database_grant, hiera_hash('mysql::server::grants',{}))
}
