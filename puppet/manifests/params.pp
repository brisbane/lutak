# Class: puppet::params
#
#   The puppet configuration settings.
class puppet::params {
  ## global settings ##

  # what to do with packages
  $package_ensure = 'present'


  ## agent settings ##

  # fqdn of puppetmaster
  $puppetmaster = 'puppet'

  # environment
  $agentenv = ''


  ## master settings ##

  # type of puppet master server, one of: puppetmaster, apache, nginx
  $server_type = 'puppetmaster'

  # wether or not to use storeconfigs
  $storeconfigs = false

  # environments
  $environments = ['production', 'test', 'dev']

  # subnets that are allowed to access "/files"
  $fileserver_clients = ['127.0.0.0/8']

  # delete reports older than value
  $report_age = '1w'
}
