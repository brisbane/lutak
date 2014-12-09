#
# = Class: puppet::params
#
# The puppet configuration settings.
class puppet::params {
  ## global settings ##

  # what to do with packages
  $package_ensure = 'present'

  # set values based on OS
  case $::operatingsystem {
    default : {
      $service = 'puppet'
    }
    'Fedora' : {
      $service = 'puppetagent'
    }
  }

  ## agent settings ##

  # fqdn of puppetmaster
  $puppetmaster = 'puppet'

  # agent name
  $cert_name = $::fqdn

  # environment
  $agentenv = ''

  # module path
  $modulepath = '$confdir/environments/$environment/modules:$confdir/modules:/usr/share/puppet/modules'



  ## master settings ##

  # type of puppet master server, one of: puppetmaster, apache, nginx
  $server_type = 'puppetmaster'

  # name of teh certificate for puppet master config
  $master_cert_name = $::fqdn

  # wether or not to use storeconfigs
  $storeconfigs = false

  # environments
  $environments = ['production', 'test', 'dev']

  # set to true to use directory environments
  $dir_environments = false

  # subnets that are allowed to access "/files"
  $fileserver_clients = ['127.0.0.0/8']

  # delete reports older than value days
  $report_age = '7'
}
