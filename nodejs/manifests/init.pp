# Class: nodejs
class nodejs {
  require yum::repo::epel::testing

  package { 'nodejs': ensure => present, }
}
