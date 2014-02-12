#
# = Class: elasticsearch
#
# This class installs elasticsearch
class elasticsearch (
  $package = 'elasticsearch',
  $version = '0.90.10',
) {

  package { 'elasticsearch' :
    ensure   => $version,
    name     => $package,
    provider => 'rpm',
    source   => 'https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.10.noarch.rpm',
  }

}
# vi:syntax=puppet:filetype=puppet:et:
