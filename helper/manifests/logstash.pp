#
# = Class: helper::logstash
#
# Installs logstash and creates configs
class helper::logstash {
  include ::yum::repo::logstash
  include ::java::oracle7
  include ::logstash

  # push config files
  $logstash_configs = hiera_hash('logstash::configfiles', {})
  create_resources(::Logstash::Configfile, $logstash_configs)
}
