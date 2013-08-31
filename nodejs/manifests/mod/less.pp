# Class: nodejs::mod::less
class nodejs::mod::less {
  include nodejs
  package {'nodejs-less': ensure => present, }
}
