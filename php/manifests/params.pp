#
# = Class: php::params
#
class php::params {
  $ensure         = 'present'
  $version        = undef

  $file_owner        = 'root'
  $file_group        = 'root'
  $file_mode         = '0644'

  $dependency_class = undef
  $my_class         = undef


  # install package depending on major version
  case $::osfamily {
    default: {}
    /(RedHat|redhat)/: {
      $package              = 'php'
      $package_common       = 'php-common'
      $package_cli          = 'php-cli'
      $file_php_ini         = '/etc/php.ini'
      $template_php_ini     = 'php/rhel_php.ini.erb'
      $dir_php_confd        = '/etc/php.d'
      $php_error_log        = ''
      $file_php_cli_ini     = '/etc/php-cli.ini'
      $template_php_cli_ini = 'php/rhel_php.ini.erb'
      $dir_php_cli_confd    = '/etc/php.d'
      $php_cli_error_log    = '/var/log/httpd/php_error_log'
      $service_fpm          = 'php-fpm'
      $mod_packages         = {
        'bcmath'   => 'php-bcmath',
        'gd'       => 'php-gd',
        'imap'     => 'php-imap',
        'intl'     => 'php-intl',
        'ldap'     => 'php-ldap',
        'mbstring' => 'php-mbstring',
        'mcrypt'   => 'php-mcrypt',
        'mysql'    => 'php-mysql',
        'pdo'      => 'php-pdo',
        'pear'     => 'php-pear',
        'pecl'     => 'php-pecl',
        'soap'     => 'php-soap',
        'xml'      => 'php-xml',
        'xmlrpc'   => 'php-xmlrpc',
      }
      $mod_pear_packages  = {
        'phing'          => 'php-pear-phing',
        'versioncontrol' => 'php-pear-versioncontrol',
      }
      $mod_pecl_packages  = {
        'amqp'        => 'php-pecl-amqp',
        'gearman'     => 'php-pecl-gearman',
        'memcache'    => 'php-pecl-memcache',
        'ssh2'        => 'php-pecl-ssh2',
        'zendopcache' => 'php-pecl-zendopcache',
        'xdebug'      => 'php-pecl-xdebug',
      }
    }
    /(Debian|debian)/: {
      $package       = 'php5'
      $dir_php_confd = '/etc/php5/conf.d'
      $service_fpm   = 'php5-fpm'
    }
  }

}
