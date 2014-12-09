# Class: simplesamlphp::params
class simplesamlphp::params {

  $authmemcookie         = false
  $package_ensure        = 'present'
  $alias                 = '/simplesamlphp'
  $directory             = '/var/www/html/'
  $username              = undef
  $idp                   = undef
  $proxyidp              = undef
  $fedlabidp             = undef
  $authadminpassword     = undef
  $secretsalt            = undef
  $technicalcontactname  = 'Technical contact'
  $technicalcontactemail = 'Technical.Contact@email'

}
