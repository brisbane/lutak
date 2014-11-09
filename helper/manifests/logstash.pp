#
# = Class: helper::logstash
#
# Installs logstash and creates configs
class helper::logstash {

  case $::operatingsystem {
    'RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux': {
      include ::java::oracle7
      include ::yum::repo::logstash
    }
    default: { }
  }

  include ::logstash

  # load configs from hiera
  $logstash_configs = hiera_hash('logstash::configfiles', {})
  create_resources(::Logstash::Configfile, $logstash_configs)
  $logstash_patterns = hiera_hash('logstash::patternfiles', {})
  create_resources(::Logstash::Patternfile, $logstash_patterns)

}
