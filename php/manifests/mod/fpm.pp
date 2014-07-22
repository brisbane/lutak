#
# = Class: php::mod::fpm
#
class php::mod::fpm (
  $service        = $::php::params::fpm_service,
  $service_enable = true,
  $service_ensure = 'running',
) inherits php::params {

  ::php::mod { 'fpm': }

  service { 'php-fpm':
    ensure  => $service_ensure,
    enable  => $service_enable,
    name    => $service,
    require => ::Php::Mod['fpm'],
    noop    => $::php::noops,
  }

}
