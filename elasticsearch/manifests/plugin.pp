#
#
#
define elasticsearch::plugin (
  $module_dir,
  $ensure      = 'present',
  $url         = ''
) {

  include ::elasticsearch

  Exec {
    path => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    cwd  => '/',
    user => $::elasticsearch::file_owner,
  }

  $notify_service = $::elasticsearch::service_restart ? {
    false   => undef,
    default => Service['elasticsearch'],
  }

  if ($url != '') {
    validate_string($url)
    $install_cmd = "${::elasticsearch::plugintool} -install ${name} -url ${url}"
    $exec_rets = [0,1]
  } else {
    $install_cmd = "${::elasticsearch::plugintool} -install ${name}"
    $exec_rets = [0,]
  }

  case $ensure {
    'installed', 'present': {
      exec {"install_plugin_${name}":
        command  => $install_cmd,
        creates  => "${::elasticsearch::plugindir}/${module_dir}",
        returns  => $exec_rets,
        notify   => $notify_service,
        require  => File[$::elasticsearch::plugindir]
      }
    }
    default: {
      exec {"remove_plugin_${name}":
        command => "${::elasticsearch::plugintool} --remove ${module_dir}",
        onlyif  => "test -d ${::elasticsearch::plugindir}/${module_dir}",
        notify  => $notify_service,
      }
    }
  }
}
