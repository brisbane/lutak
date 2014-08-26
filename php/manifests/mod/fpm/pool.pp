#
# = Define: php::mod::fpm::pool
#
define php::mod::fpm::pool (
  $listen               = '127.0.0.1:9000',
  $allowed_clients      = '127.0.0.1',
  $owner                = undef,
  $group                = undef,
  $mode                 = undef,
  $pm                   = 'dynamic',
  $pm_max_children      = '50',
  $pm_start_servers     = '5',
  $pm_min_spare_servers = '5',
  $pm_max_spare_servers = '35',
  $pm_max_requests      = '500',
  $template             = 'puppet:///php/fpm/pool.conf.erb',
) {

  $pool_name = $title

  include ::php
  include ::php::mod::fpm

}
