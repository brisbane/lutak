# Class: simplesamlphp
#
# This module manages simplesamlphp
#
# Parameters: none
#
# Actions: Manages simplesamlphp with memcookie
#
# Requires: srce repo
#
# Sample Usage:
#

class simplesamlphp (
  $authmemcookie         = $simplesamlphp::params::authmemcookie,
  $package_ensure        = $simplesamlphp::params::package_ensure,
  $alias                 = $simplesamlphp::params::alias,
  $directory             = $simplesamlphp::params::directory,
  $username              = $simplesamlphp::params::username,
  $idp                   = $simplesamlphp::params::idp,
  $proxyidp              = $simplesamlphp::params::proxyidp,
  $fedlabidp             = $simplesamlphp::params::fedlabidp,
  $authadminpassword     = $simplesamlphp::params::authadminpassword,
  $secretsalt            = $simplesamlphp::params::secretsalt,
  $technicalcontactname  = $simplesamlphp::params::technicalcontactname,
  $technicalcontactemail = $simplesamlphp::params::technicalcontactemail,
) inherits ::simplesamlphp::params {

  class{'simplesamlphp::package': } ->
  class{'simplesamlphp::config':  } ->
  Class['simplesamlphp']

}

