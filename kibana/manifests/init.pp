#
# = Class: kibana
#
class kibana (
  $ensure               = $::kibana::params::ensure,
  $package              = $::kibana::params::package,
  $version              = $::kibana::params::version,
  $template_kibana_conf = undef,
  $allow_from           = [ '127.0.0.1', '::1' ],
  $webserver            = undef,
  $elasticsearch        = 'http://"+window.location.hostname+":9200',
  $dependency_class     = $::kibana::params::dependency_class,
  $my_class             = $::kibana::params::my_class,
  $noops                = undef,
) inherits kibana::params {

  ### Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent')
  validate_string($package)
  validate_string($version)

  ### Internal variables (that map class parameters)
  if $ensure == 'present' {
    $package_ensure = $version ? {
      ''      => 'present',
      default => $version,
    }
    $file_ensure = 'present'
  } else {
    $package_ensure = 'absent'
    $file_ensure    = 'absent'
  }

  # determine how to set up web server
  case $webserver {
    'apache': {
      include ::apache
      $service_name       = $::apache::service_name
      $confd_dir          = $::apache::confd_dir
      $template_webserver = 'kibana/kibana.conf_apache.erb'
    }
    'nginx':  {
      include ::nginx
      $service_name       = $::nginx::service_name
      $confd_dir          = $::nginx::confd_dir
      $template_webserver = 'kibana/kibana.conf_nginx.erb'
    }
    default:  {}
  }

  # which template to use
  if ( $template_kibana_conf ) {
    $template_name = $template_kibana_conf
  } else {
    $template_name = $template_webserver
  }

  ### Extra classes
  if $dependency_class { include $dependency_class }
  if $my_class         { include $my_class         }

  ### Code
  package { 'kibana':
    ensure => $package_ensure,
    name   => $package,
    noop   => $noops,
  }

  if ( $webserver ) {
    file { "${confd_dir}/kibana.conf" :
      ensure  => $file_ensure,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template($template_name),
      require => Package['kibana'],
      notify  => Service[$service_name],
    }
  }

}
