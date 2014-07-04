#
# = Class: helper::postgresql
#
# Installs postgresql and creates roles/databases/hbas from Hiera hashes
class helper::postgresql {
  # postgresql
  include ::postgresql::client
  include ::postgresql::server

  # roles
  $postgresql_roles = hiera_hash('postgresql::roles', {})
  create_resources(::Postgresql::Server::Role, $postgresql_roles)

  # databases
  $postgresql_databases = hiera_hash('postgresql::databases', {})
  create_resources(::Postgresql::Server::Database, $postgresql_databases)

  # Host based access rules
  $postgresql_hba_rules = hiera_hash('postgresql::hba_rules', {})
  create_resources(::Postgresql::Server::Pg_hba_rule, $postgresql_hba_rules)

  # Config lines
  $postgresql_config_entries = hiera_hash('postgresql::server::config_entries', {})
  create_resources(::Postgresql::Server::Config_Entry, $postgresql_config_entries)

}
