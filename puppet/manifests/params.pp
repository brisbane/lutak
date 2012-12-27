# Class: puppet::params
#
#   The puppet configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::params {
  $package_ensure = 'present'
  # fqdn of puppetmaster
  $puppetmaster = 'puppet'
  # subnets that are allowed to access "/files"
  # section from puppetmaster web server
  $fileserver_clients = ['127.0.0.0/8']
  # type of puppet master server, one of:
  #  puppetmaster, apache, nginx
  $server_type = 'puppetmaster'
  # environments
  $environments = ['production', 'test', 'dev']
}
